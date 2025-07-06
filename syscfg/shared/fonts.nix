{ pkgs, inputs, constants, ... }:
let
  themeFonts = constants.themes.fonts;
in
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ themeFonts.mono ];
        sansSerif = [ themeFonts.sans ];
      };
    };
  };
}
