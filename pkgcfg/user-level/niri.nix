{ pkgs, ... }:
{
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

  home.file = {
    ".config/niri/config.kdl".source = ../../dotfiles/niri-config.kdl;
  };
}
