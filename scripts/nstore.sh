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
  deps <path>     Show the dependency tree for a given nix store path
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
nixstore::path.system_packages () {
  nix eval --json .#nixosConfigurations.slab.config.environment.systemPackages \
    | jq -r '.[]' \
    | nixstore::path.filter_unrealized
}

nixstore::path.user_packages () {
  local home_manager_=$(realpath ~/.local/state/nix/profiles/home-manager)
  
  nix-store --query --references $home_manager_ \
    | grep -vE '\.(sh|.css|.json|.ini)$' \
    | grep -vE 'home-manager-(files|path|generation)$'
}

nixstore::path.installed_packages () {
  {
    nixstore::path.system_packages;
    nixstore::path.user_packages;
  } | sort -u
}

nixstore::path.join_size () {
  parallel --no-notice --colsep '\t' --plus \
    'nix path-info --closure-size {1}'
}

nixstore::path.join_name () {
  parallel --no-notice --colsep '\t' --plus \
    'echo -en "{}\t"; nix derivation show {1} | jq -r "to_entries[0].value.env.pname"'
}

nixstore::path.installed_packages_by_size () {
  nixstore::path.installed_packages \
    | nixstore::path.join_size \
    | nixstore::path.join_name \
    | sort -rn -k2 \
    | uniq \
    | format::bytes.humanize \
    | column -s $'\t' -t
}

nixstore::path.filter_unrealized () {
  while read -r path_; do
    if [ -e $path_ ]; then
      echo $path_;
    fi
  done
}

format::bytes.humanize () {
  awk ' \
    BEGIN { \
      print "\033[1;35m" "NAME\tPATH\tSIZE" "\033[0m"; \
      human[1073741824]="GB"; \
      human[1048576]="MB"; \
      human[1024]="KB"; \
    } \
    { \
      path=$1;size=$2;name=$3; \
      for (x = 1073741824; x >= 1024; x /= 1024) {  \
        if (size >= x) { \
          printf "%s\t%s\t%9.2f %s\n", name, path, size / x, human[x]; \
          next \
        } \
      } \
      printf "%s\t%s\t%9d B\n", name, path, size; \
    }'   
}

nixstore::path.dependency_tree () {
  local path_=$1; shift
  
  nix why-depends $(readlink -f /nix/var/nix/profiles/system) $path_
}

main () {
  local command_=${1:-help}; shift || true

  if within "list" "ls" $command_; then
    nixstore::path.installed_packages_by_size
  elif equal "deps" $command_; then
    nixstore::path.dependency_tree $@
  elif within "help" "-h" "--help" $command_; then
    cli::help.print
  else
    errors::bad_command.print "$command_"
    cli::help.print
    exit 1
  fi
}

main "$@"
