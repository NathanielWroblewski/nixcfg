{ pkgs, ... }: with pkgs; [
  brightnessctl # control screen brightness
  fuzzel # application launcher
  nautilus # file explorer
  pavucontrol # audio settings gui
  polkit_gnome # policy kit client/agent for authorization
  swaybg # set background images
  swayidle # wayland idle manager
  swaylock-effects # wayland screen locking utility
  waybar # system tray / bar
  wl-clipboard # clipboard
  xwayland-satellite # use wayland outside your compositor
]
