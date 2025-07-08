{ pkgs, inputs, constants, ... }:
let
  fonts = constants.themes.fonts;
  theme = constants.themes.colors.global;
in
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.name.hyphenated}.yaml";

    fonts = {
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = fonts.sans;
      };
      monospace = {
        package = pkgs.jetbrains-mono;
        name = fonts.mono;
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
