{ pkgs, ... }:
{
  packages = with pkgs; [
    whitesur-gtk-theme # mac-style application theming
    whitesur-icon-theme # mac-style icons
    capitaine-cursors # mac-style cursors
  ];
}
