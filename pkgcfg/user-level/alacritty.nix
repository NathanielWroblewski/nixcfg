{ constants, ... }:
let
  fonts = constants.themes.fonts;
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      window.padding = {
        x = 10;
        y = 10;
      };

      window.decorations = "none";

      window.opacity = 0.80;

      scrolling.history = 10000;

      font = {
        size = 12;

        normal = {
          family = fonts.mono;
          style = "Regular";
        };

        bold = {
          family = fonts.mono;
          style = "Bold";
        };

        italic = {
          family = fonts.mono;
          style = "Italic";
        };

        bold_italic = {
          family = fonts.mono;
          style = "Bold Italic";
        };
      };

      #   keyboard.bindings = [
      #     {
      #       key = "K";
      #       mods = "Control";
      #       chars = "\\u000c";
      #     }
      #   ];

    };

    theme = "tokyo_night";
  };

  # home.file.".config/alacritty/alacritty.yml".text = ''
  #   font:
  #     features:
  #       - "+liga"
  #       - "+calt"
  #       - "+clig"
  # '';
}
