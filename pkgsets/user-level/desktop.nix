{ pkgs, ... }: with pkgs; [
  brightnessctl # control screen brightness
  fuzzel # application launcher
  losslesscut-bin # video editing
  nautilus # file explorer
  obs-studio # screen recording
  pavucontrol # audio settings gui
  polkit_gnome # policy kit client/agent for authorization
  swaybg # set background images
  swayidle # wayland idle manager
  swaylock-effects # wayland screen locking utility
  waybar # system tray / bar
  wl-clipboard # clipboard
  xwayland-satellite # use wayland outside your compositor
]
