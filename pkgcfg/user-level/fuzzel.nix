{ lib, constants, ... }:
let
  fonts = constants.themes.fonts;
  colors = constants.themes.colors.app_launcher;

  # rgb hex value colors
  background = lib.removePrefix "#" colors.primary.background;
  foreground = lib.removePrefix "#" colors.primary.foreground;
  white = lib.removePrefix "#" colors.normal.white;
  black = lib.removePrefix "#" colors.normal.black;
  cyan = lib.removePrefix "#" colors.normal.cyan;

  # opacity hex values
  transparent = "d9"; # 85% opacity
  opaque = "ff";
in
{
  programs.fuzzel = {
    enable = true;

    settings = lib.mkForce {
      main = {
        font = fonts.mono + ":size=12";
        use-bold = true;
        placeholder = "Search…";
        prompt = "\"  \"";
        icon-theme = "hicolor";
        icons-enabled = true;
        hide-before-typing = false;
        terminal = "wezterm";
        tabs = 2;
        exit-on-keyboard-focus-loss = true;

        # layer="top" -> above normal windows, below fullscreen windows and lockscreen
        # layer="overlay" -> above normal windows and fullscreen windows, below lockscreen
        layer = "overlay";

        # styles
        anchor = "center";
        x-margin = 0;
        y-margin = 0;
        lines = 5;
        width = 30;
        horizontal-pad = 15;
        vertical-pad = 10;
        inner-pad = 5;
        line-height = 22;
      };

      # colors are rgba hex values
      colors = {
        background = background + transparent;
        text = white + opaque;
        prompt = white + opaque;
        placeholder = white + opaque;
        input = foreground + opaque;
        match = foreground + opaque;
        selection = cyan + opaque;
        selection-text = background + opaque;
        selection-match = black + opaque;
        counter = background + transparent;
        border = background + transparent;
      };

      border = {
        width = 0;
        radius = 10;
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
