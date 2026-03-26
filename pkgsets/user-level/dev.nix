{ pkgs, ... }: with pkgs; [
  alacritty # terminal
  parallel # gnu parallel
  htop # resource utilization
  unzip # unarchive
  jq # query JSON
  tree # crawl a directory
  # curl is pre-installed.
  # gawk is pre-installed.
  # sed is pre-installed.
  ripgrep # grep
  starship # cli prompt
  yazi # terminal file manager
  lutgen # apply color themes to images
  ffmpeg
  sublime4 # editor
]
