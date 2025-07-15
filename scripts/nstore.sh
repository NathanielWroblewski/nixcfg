#!/usr/bin/env bash

# Utility for visualizing nix-store disk usage
# Dependencies: bash, nix, nix-store, jq

set -o noglob
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

IFS=$'\n'

# docstring
USAGE=$(cat <<'EOF'
Usage: nstore <command> [args]

Utility for visualizing nix-store disk usage.

Commands:
  list            List packages by disk usage (aggregates transitive dependencies)
  ls              List packages by disk usage (aggregates transitive dependencies)
  sysdep <path>   Show the dependency tree for a given system dependency nix store path
  help            Print this help message
  -h              Print this help message
  --help          Print this help message
EOF
)

equal () {
  [[ "$1" == "$2" ]]
}

within () {
  local needle_=${@: -1}
  local -a haystack_=(${@:1:$#-1})

  for element_ in ${haystack_[@]}; do
    equal $element_ $needle_ && return 0
  done

  return 1
}

enums::map () {
  local fn=$1
  local arg

  while read -r arg; do
    $fn $arg;
  done
}

cli::help.print () {
  echo "$USAGE"
}

errors::bad_command.print () {
  echo -e "Bad command: $1\n" >&2
}

# TODO: Figure out how to determine slab index
pkgs::system.all () {
  nix eval --json .#nixosConfigurations.slab.config.environment.systemPackages \
    | jq -r '.[]'
}

pkgs::user.all () {
  local home_manager_=$(realpath ~/.local/state/nix/profiles/home-manager)
  
  nix-store --query --references $home_manager_ \
    | grep -vE '\.(sh|.css|.json|.ini)$' \
    | grep -vE 'home-manager-(files|path|generation)$'
}

pkgs::installed.all () {
  { pkgs::system.all; pkgs::user.all; } | sort -u
}

pkgs::installed.join_size () {
  pkgs::installed.all \
    | parallel --no-notice 'nix path-info --closure-size {}' \
    | sort -rn -k2 \
    | uniq \
    | format::size.humanize \
    | column -s $'\t' -t
}

format::size.humanize () {
  awk ' \
    BEGIN { print "\033[1;35m" "PATH\tSIZE" "\033[0m" } \
    { \
      size = $2; \
      human[1073741824]="GB"; \
      human[1048576]="MB"; \
      human[1024]="KB"; \
      for (x = 1073741824; x >= 1024; x /= 1024) {  \
        if (size >= x) { \
          printf "%s\t%9.2f %s\n", $1, size / x, human[x]; \
          next \
        } \
      } \
      printf "%s\t%9d B\n", $1, size; \
    }'   
}

system::package.dependency_tree () {
  local path_=$1; shift
  
  nix why-depends $(readlink -f /nix/var/nix/profiles/system) $path_
}

main () {
  local command_=${1:-help}; shift || true

  if within "list" "ls" $command_; then
    pkgs::installed.join_size
  elif equal "sysdep" $command_; then
    system::package.dependency_tree $@
  elif within "help" "-h" "--help" $command_; then
    cli::help.print
  else
    errors::bad_command.print "$command_"
    cli::help.print
    exit 1
  fi
}

main "$@"
