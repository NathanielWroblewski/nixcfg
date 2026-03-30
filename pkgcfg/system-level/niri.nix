{ pkgs, ... }:
{
  programs.niri.enable = true;

  # enable screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    config.common.default = [
      "gnome"
      "gtk"
    ];
  };

}
