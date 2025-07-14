#!/usr/bin/env bash

# Convenience commands around network manager interactions
# Dependencies: bash, networkmanager

set -o noglob
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

IFS=$'\n'

# docstring
USAGE=$(cat <<'EOF'
Usage: wifi <command> [args]

Convenience commands for interacting with NetworkManager (nmcli)
to {en,dis}able wifi, list networks, {dis,}connect to a network, etc.

Commands:
  on              Enable wifi
  off             Disable wifi
  list            List available networks
  ls              List available networks
  join <SSID>     Join a network
  connect <SSID>  Join a network
  drop            Disconnect from current network
  disconnect      Disconnect from current network
  active          Display active connection
  connection      Display active connection
  current         Display active connection
  status          Display active connection
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

network::wifi.on () {
  nmcli radio wifi on
}

network::wifi.off () {
  nmcli radio wifi off
}

network::wifi.list () {
  nmcli \
    --colors no \
    --fields SSID,RATE,SIGNAL,BARS,SECURITY \
    --terse \
    device wifi list \
    | awk -F ':' \
      'BEGIN { print "\033[1;35m" "SSID\tRATE\tSIGNAL\tBARS\tSECURITY" "\033[0m" } \
      $1 == "" { next } \
      !seen[$1]++ { gsub(":", "\t"); print }' \
    | column -s $'\t' -t
}

network::wifi.is_known () {
  local ssid_=$1

  nmcli connection show "$ssid_" &>/dev/null
}

network::wifi.join () {
  local ssid_=$1

  if network::wifi.is_known "$ssid_"; then
    nmcli connection up "$ssid_"
    return
  fi
  
  local password_=$(cli::password.prompt $ssid_)

  if equal "$password_" ""; then
    nmcli device wifi connect "$ssid_"
  else
    nmcli device wifi connect "$ssid_" password "$password_"   
  fi
}

network::wifi.disconnect () {
  local device_=$(nmcli device status | awk '/wifi/ && / connected/ { print $1 }') # e.g. wlo1
  
  nmcli device down $device_
}

network::wifi.active_connection () {  
  nmcli \
    --fields CONNECTION,TYPE,STATE,DEVICE \
    --colors no \
    device status \
    | awk \
      'NR==1 { print "\033[1;35m" $0 "\033[0m" } \
      /wifi / && / connected/ { print }'
}

cli::help.print () {
  echo "$USAGE"
}

cli::password.prompt () {
  local ssid_=$1; shift
  
  echo -n "Enter password for SSID $ssid_" >&2
  read -s password_
  echo >&2

  echo "$password_"
}

errors::bad_command.print () {
  echo -e "Bad command: $1\n" >&2
}

main () {
  local command_=${1:-help}; shift || true

  if equal "on" $command_; then
    network::wifi.on
  elif equal "off" $command_; then
    network::wifi.off
  elif within "list" "ls" $command_; then
    network::wifi.list
  elif within "join" "connect" $command_; then
    network::wifi.join "$@"
  elif within "drop" "disconnect" $command_; then
    network::wifi.disconnect
  elif within "connection" "active" "current" "status" $command_; then
    network::wifi.active_connection
  elif within "help" "-h" "--help" $command_; then
    cli::help.print
  else
    errors::bad_command.print "$command_"
    cli::help.print
    exit 1
  fi
}

main "$@"
