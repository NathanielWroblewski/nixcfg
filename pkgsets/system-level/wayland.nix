{ pkgs, ... }: with pkgs; [
  niri # wayland compositor, tiling window manager
  greetd.tuigreet # display manager and login
  libinput
]
