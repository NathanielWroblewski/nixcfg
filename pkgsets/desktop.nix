{ pkgs, ... }:
{
  wayland = {
    niri = {
      packages = with pkgs; [
        xwayland-satellite # use wayland outside your compositor
        niri # wayland compositor, tiling window manager
        greetd.tuigreet # display manager and login, optional
        brightnessctl # control screen brightness
        waybar # system tray / bar
        rofi # application launcher and window switcher
        nautilus # file explorer
        zsh # shell
      ];
    };
  };
}
