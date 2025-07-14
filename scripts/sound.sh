#!/usr/bin/env bash

# Convenience commands around wireplumber interactions
# Dependencies: bash, wpctl

set -o noglob
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

IFS=$'\n'

# docstring
USAGE=$(cat <<'EOF'
Usage: sound <command> [args]

Convenience commands for interacting with pipewire/wireplumber (wpctl)
to {un,}mute, control volume, and {en,dis}able {in,out}puts.

Commands:
  input           Show current active input device
  in              Show current active input device
  inputs          List input devices (microphones)
  ins             List input devices (microphones)
  output          Show current active output device
  out             Show current active output device
  outputs         List output devices (speakers/headphones)
  outs            List output devices (speakers/headphones)
  switch <ID>     Promotes the {in,out}put to current active
  mute            Mutes the microphone
  unmute          Unmutes the microphone
  squelch         Mutes the speakers
  off             Mutes the speakers
  unsquelch       Unmutes the speakers
  on              Unmutes the speakers
  gain <%>        Sets the input volume
  volume <%>      Sets the output volume
  vol <%>         Sets the output volume
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

sound::inputs.all () {
  wpctl status \
    | awk \
      'BEGIN { print "\033[1;35m" "STATUS\tID\tINPUT DEVICE\tVOLUME" "\033[0m" } \
      /Audio/ { in_audio = 1 } \
      in_audio && /Sources/ { in_sources = 1 } \
      in_audio && in_sources && /vol/ { \
        match($0, /^[[:space:]]+│[[:space:]]+(\*?)[[:space:]]+([0-9]+)\.[[:space:]]+(.*)[[:space:]]+\[vol: ([0-9.]+)\]/, m); \
        if (m[2] && m[3] && m[4]) { \
          status = (m[1] == "*") ? "active" : "inactive"; \
          id = m[2]; \
          device = m[3]; \
          vol = int(m[4] * 100); \
          gsub(/[[:space:]]+$/, "", device); \
          printf "%s\t%s\t%s\t%d%%\n", status, id, device, vol \
        } \
      } \
      /Filters/ { in_sources = 0 } \
      /Video/ { in_audio = 0 }' \
    | column -s $'\t' -t
}

sound::outputs.all () {
  wpctl status \
    | awk \
      'BEGIN { print "\033[1;35m" "STATUS\tID\tOUTPUT DEVICE\tVOLUME" "\033[0m" } \
      /Audio/ { in_audio = 1 } \
      in_audio && /Sinks/ { in_sinks = 1 } \
      in_audio && in_sinks && /vol/ { \
        match($0, /^[[:space:]]+│[[:space:]]+(\*?)[[:space:]]+([0-9]+)\.[[:space:]]+(.*)[[:space:]]+\[vol: ([0-9.]+)\]/, m); \
        if (m[2] && m[3] && m[4]) { \
          status = (m[1] == "*") ? "active" : "inactive"; \
          id = m[2]; \
          device = m[3]; \
          vol = int(m[4] * 100); \
          gsub(/[[:space:]]+$/, "", device); \
          printf "%s\t%s\t%s\t%d%%\n", status, id, device, vol \
        } \
      } \
      /Sources/ { in_sinks = 0 } \
      /Video/ { in_audio = 0 }' \
    | column -s $'\t' -t      
}

sound::device.switch () {
  local inputOrOutputId_=$1; shift

  wpctl set-default $inputOrOutputId_
}

# Current active input
sound::input.active () {
  wpctl status \
    | awk \
      'BEGIN { print "\033[1;35m" "STATUS\tID\tINPUT DEVICE\tVOLUME" "\033[0m" } \
      /Audio/ { in_audio = 1 } \
      /Sources/ { in_sources = 1 } \
      in_audio && in_sources && / \* / { \
        match($0, /^[[:space:]]+│[[:space:]]+\*[[:space:]]+([0-9]+)\.[[:space:]]+(.*)[[:space:]]+\[vol: ([0-9.]+)\]/, m);
        if (m[1] && m[2] && m[3]) { \
          id = m[1]; \
          device = m[2]; \
          vol = int(m[3] * 100); \
          gsub(/[[:space:]]+$/, "", device); \
          printf "active\t%s\t%s\t%d%%\n", id, device, vol \
        } \
      } \
      /Filters/ { in_sources = 0 } \
      /Video/ { in_audio = 0 }' \
    | column -s $'\t' -t      
}

sound::input.mute () {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
}

sound::input.unmute () {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
}

sound::input.set_volume () {  
  local percent_=$1; shift
  local level_=$(awk "BEGIN { printf \"%.2f\", $percent_ / 100}")

  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ $level_
}

# Current active output
sound::output.active () {
  wpctl status \
    | awk \
      'BEGIN { print "\033[1;35m" "STATUS\tID\tOUTPUT DEVICE\tVOLUME" "\033[0m" } \
      /Audio/ { in_audio = 1 } \
      /Sinks/ { in_sinks = 1 } \
      in_audio && in_sinks && / \* / { \
        match($0, /^[[:space:]]+│[[:space:]]+\*[[:space:]]+([0-9]+)\.[[:space:]]+(.*)[[:space:]]+\[vol: ([0-9.]+)\]/, m);
        if (m[1] && m[2] && m[3]) { \
          id = m[1]; \
          device = m[2]; \
          vol = int(m[3] * 100); \
          gsub(/[[:space:]]+$/, "", device); \
          printf "active\t%s\t%s\t%d%%\n", id, device, vol \
        } \
      } \
      /Sources/ { in_sinks = 0 } \
      /Video/ { in_audio = 0 }' \
    | column -s $'\t' -t
}

sound::output.mute () {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
}

sound::output.unmute () {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
}

sound::output.set_volume () {
  local percent_=$1; shift
  local level_=$(awk "BEGIN { printf \"%.2f\", $percent_ / 100}")

  wpctl set-volume @DEFAULT_AUDIO_SINK@ $level_
}

cli::help.print () {
  echo "$USAGE"
}

errors::bad_command.print () {
  echo -e "Bad command: $1\n" >&2
}

main () {
  local command_=${1:-help}; shift || true

  if within "inputs" "ins" $command_; then
    sound::inputs.all
  elif within "outputs" "outs" $command_; then
    sound::outputs.all
  elif within "input" "in" $command_; then
    sound::input.active
  elif within "output" "out" $command_; then
    sound::output.active
  elif equal "switch" $command_; then
    sound::device.switch "$@"
  elif equal "mute" $command_; then
    sound::input.mute
  elif equal "unmute" $command_; then
    sound::input.unmute
  elif within "squelch" "off" $command_; then
    sound::output.mute
  elif within "unsquelch" "on" $command_; then
    sound::output.unmute
  elif equal "gain" $command_; then
    sound::input.set_volume "$@"
  elif within "volume" "vol" $command_; then
    sound::output.set_volume "$@"
  elif within "help" "-h" "--help" $command_; then
    cli::help.print
  else
    errors::bad_command.print "$command_"
    cli::help.print
    exit 1
  fi
}

main "$@"
