{ constants, ... }:
let
  fonts = constants.themes.fonts;
in
{
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ fonts.mono ];
      };
    };
  };
}
