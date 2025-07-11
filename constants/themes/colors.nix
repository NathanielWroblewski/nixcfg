rec {
  terminal = tokyo_night; # wezterm
  lockscreen = tokyo_night; # swaylock-effects
  tray = tokyo_night; # waybar
  app_launcher = tokyo_night;
  global = tokyo_night_storm; # stylix

  # hyphenated names are used by stylix to map to:
  # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16

  tokyo_night = {
    name = {
      titleized = "Tokyo Night";
      snake = "tokyo_night";
      oneword = "tokyonight";
      hyphenated = "tokyo-night-dark";
    };

    bright = {
      black = "#444b6a";
      blue = "#7da6ff";
      cyan = "#0db9d7";
      green = "#b9f27c";
      magenta = "#bb9af7";
      red = "#ff7a93";
      white = "#acb0d0";
      yellow = "#ff9e64";
    };

    normal = {
      black = "#32344a";
      blue = "#7aa2f7";
      cyan = "#449dab";
      green = "#9ece6a";
      magenta = "#ad8ee6";
      red = "#f7768e";
      white = "#787c99";
      yellow = "#e0af68";
    };

    primary = {
      background = "#1a1b26";
      foreground = "#a9b1d6";
    };
  };

  tokyo_night_storm = {
    name = {
      hyphenated = "tokyo-night-storm";
    };
  };
}
