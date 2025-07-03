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

      window.opacity = 0.8;

      scrolling.history = 10000;

      font = {
        size = 12;

        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };

        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };

        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrains Mono";
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
}
