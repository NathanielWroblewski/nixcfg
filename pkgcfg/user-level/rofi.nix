{ constants, ... }:
let
  fonts = constants.themes.fonts;
in
{
  programs.rofi = {
    enable = true;

    font = fonts.mono;

    # terminal = path to alacritty
    theme = "solarized";
    # configPath
    # modes = [];
    # extraConfig = keybindings...
  };
}
