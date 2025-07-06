{ pkgs, constants, ... }:
let
  themeFonts = constants.themes.fonts;
in
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ themeFonts.mono ];
      };
    };
  };
}
