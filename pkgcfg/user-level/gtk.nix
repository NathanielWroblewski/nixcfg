{ pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      # find theme name in /run/current-system/sw/share/themes
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme;
    };

    iconTheme = {
      # find theme name in /run/current-system/sw/share/icons
      name = "WhiteSur-light";
      package = pkgs.whitesur-icon-theme;
    };
  };
}
