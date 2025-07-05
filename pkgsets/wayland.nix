{ pkgs, ... }:
{
  packages = with pkgs; [
    xwayland-satellite # use wayland outside your compositor
    niri # wayland compositor, tiling window manager
    greetd.tuigreet # display manager and login, optional
    brightnessctl # control screen brightness
    waybar # system tray / bar
    swayidle # wayland idle manager
    swaylock # wayland screen locking utility
    swaylock-effects # more aesthetic and functional screenlocker
    rofi # application launcher and window switcher
    nautilus # file explorer
  ];
}
