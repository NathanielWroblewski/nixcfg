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
  syspkgs         List system packages by disk usage (aggregates transitive dependencies)
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
system::package.all () {
  nix eval --json .#nixosConfigurations.slab.config.environment.systemPackages \
  | jq -r '.[]' \
  | grep -v '4ankx7djqh6if0apg5fcg84kdx8d3isp-getconf-glibc-2.40-66' \
  | parallel --no-notice 'nix path-info --closure-size {}' \
  | sort -rn -k2 \
  | uniq \
  | awk ' \
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
    }' \
  | column -s $'\t' -t
}

system::package.dependency_tree () {
  local path_=$1; shift
  
  nix why-depends $(readlink -f /nix/var/nix/profiles/system) $path_
}

main () {
  local command_=${1:-help}; shift || true

  if equal "syspkgs" $command_; then
    system::package.all
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
