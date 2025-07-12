{ pkgs, ... }:
{
  packages = with pkgs; [
    xwayland-satellite # use wayland outside your compositor
    niri # wayland compositor, tiling window manager
    greetd.tuigreet # display manager and login, optional
    brightnessctl # control screen brightness
    waybar # system tray / bar
    swayidle # wayland idle manager
    swaylock-effects # wayland screen locking utility
    fuzzel # application launcher
    nautilus # file explorer
    swaybg # set background images
  ];
}
