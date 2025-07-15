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

# Predicate checking if first argument equals second argument
equal () {
  [[ "$1" == "$2" ]]
}

# Predicate to check if last argument is among the remaining arguments
within () {
  local needle_=${@: -1}
  local -a haystack_=(${@:1:$#-1})

  for element_ in ${haystack_[@]}; do
    equal $element_ $needle_ && return 0
  done

  return 1
}

# Util to map over input and invoke a function
enums::map () {
  local fn=$1
  local arg

  while read -r arg; do
    $fn $arg;
  done
}

# Prints the command usage documentation
cli::help.print () {
  echo "$USAGE"
}

# Prints an error if the user passes an unknown command
errors::bad_command.print () {
  echo -e "Bad command: $1\n" >&2
}

# Returns nix-store paths of system packages
nixstore::path.system_packages () {
  local hostname_=$(hostnamectl --static)
  
  nix eval --json .#nixosConfigurations.$hostname_.config.environment.systemPackages \
    | jq -r '.[]' \
    | grep -vE '\.(sh|css|json|ini|Xresources|conf|kvconfig|keep|js|lua|xml|kdl|theme|tmTheme|target|zshenv|toml|yaml|yml)$' \
    | enums::map nixstore::path.exists
}

# Returns nix-store paths of home manager packages
nixstore::path.user_packages () {
  local home_manager_=$(realpath ~/.local/state/nix/profiles/home-manager)
  
  nix-store --query --requisites $home_manager_ \
    | grep -vE '\.(sh|css|json|ini|Xresources|conf|kvconfig|keep|js|lua|xml|kdl|theme|tmTheme|target|zshenv|toml|yaml|yml)$' \
    | grep -vE 'home-manager-(files|path|generation)$'
}

# Returns nix-store paths of installed packages
nixstore::path.installed_packages () {
  {
    nixstore::path.system_packages;
    nixstore::path.user_packages;
  } | sort -u
}

# Given nix-store paths, performs a look-up to join package size
nixstore::path.join_size () {
  parallel --no-notice --colsep '\t' --plus \
    'nix path-info --closure-size {1}'
}

# Given nix-store paths, performs a look-up to join package name 
nixstore::path.join_name () {
  parallel --no-notice --colsep '\t' --plus \
    'echo -en "{}\t"; nix derivation show {1} | jq -r "to_entries[0].value.env.pname"'
}

# Returns a sorted list of package name, nix-store path, and size
nixstore::path.installed_packages_by_size () {
  nixstore::path.installed_packages \
    | nixstore::path.join_size \
    | nixstore::path.join_name \
    | sort -rn -k2 \
    | uniq \
    | format::bytes.humanize \
    | column -s $'\t' -t
}

# Predicate to check if the path exists
nixstore::path.exists () {
  local path_=$1; shift

  if [ -e $path_ ]; then
    echo $path_;
  fi
}

# Formats the dataset as a table with human-readable bytes
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

# Surfaces the dependency tree of a given nix-store path
nixstore::path.dependency_tree () {
  local path_=$1; shift
  
  nix why-depends $(readlink -f /nix/var/nix/profiles/system) $path_
}

# Entrypoint of the script, routes commands to handlers
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
