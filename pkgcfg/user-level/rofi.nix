{ config, constants, lib, ... }:
{
  programs.rofi = {
    enable = true;

    # font + size
    font = constants.themes.fonts.mono + " 10";

    # where rofi should be positioned
    location = "center";
    # xoffset
    # yoffset

    modes = [ "drun" "run" "filebrowser" "window" ];

    extraConfig = {
      modi = "drun,run,filebrowser,window";
      show-icons = true;
      display-drun = "";
      display-run = "";
      display-filebrowser = "";
      display-window = "";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };

    # plugins = [];

    theme =
      let
        # Use `mkLiteral` for string-like values that should show without
        # quotes, e.g.:
        #   background-color = mkLiteral "var(background)";
        inherit (config.lib.formats.rasi) mkLiteral;
        colors = constants.themes.colors.app_launcher;
        lit_inherit = mkLiteral "inherit";
      in
      lib.mkForce {
        "*" = {
          # colors
          background = mkLiteral "${colors.primary.background}";
          background-alt = mkLiteral "${colors.normal.black}";
          foreground = mkLiteral "${colors.primary.foreground}";
          selected = mkLiteral "${colors.normal.cyan}";
          active = mkLiteral "${colors.normal.white}";
          urgent = mkLiteral "${colors.normal.red}";

          # global properties
          border-color = mkLiteral "var(selected)";
          handle-color = mkLiteral "var(selected)";
          background-color = mkLiteral "var(background)";
          foreground-color = mkLiteral "var(foreground)";
          alternate-background = mkLiteral "var(background-alt)";
          normal-background = mkLiteral "var(background)";
          normal-foreground = mkLiteral "var(foreground)";
          urgent-background = mkLiteral "var(urgent)";
          urgent-foreground = mkLiteral "var(background)";
          active-background = mkLiteral "var(active)";
          active-foreground = mkLiteral "var(background)";
          selected-normal-background = mkLiteral "var(selected)";
          selected-normal-foreground = mkLiteral "var(background)";
          selected-urgent-background = mkLiteral "var(active)";
          selected-urgent-foreground = mkLiteral "var(background)";
          selected-active-background = mkLiteral "var(urgent)";
          selected-active-foreground = mkLiteral "var(background)";
          alternate-normal-background = mkLiteral "var(background)";
          alternate-normal-foreground = mkLiteral "var(foreground)";
          alternate-urgent-background = mkLiteral "var(urgent)";
          alternate-urgent-foreground = mkLiteral "var(background)";
          alternate-active-background = mkLiteral "var(active)";
          alternate-active-foreground = mkLiteral "var(background)";
        };

        window = {
          transparency = "real";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          fullscreen = false;
          width = mkLiteral "600px";
          x-offset = 0;
          y-offset = 0;
          enabled = true;
          margin = 0;
          padding = 0;
          border = mkLiteral "0px solid";
          border-radius = "10px";
          border-color = mkLiteral "@border-color";
          cursor = "default";
          background-color = mkLiteral "@background-color";
        };

        mainbox = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = 0;
          padding = mkLiteral "30px";
          border = mkLiteral "0px solid";
          border-radius = 0;
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          children = [ "inputbar" "message" "listview" ];
        };

        # Begin input bar
        inputbar = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = 0;
          padding = 0;
          border = mkLiteral "0px solid";
          border-radius = 0;
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-color";
          children = [ "textbox-prompt-colon" "entry" "mode-switcher" ];
        };

        prompt = {
          enabled = true;
          background-color = lit_inherit;
          text-color = lit_inherit;
        };

        textbox-prompt-color = {
          enabled = true;
          padding = mkLiteral "5px 0";
          expand = false;
          str = "";
          background-color = lit_inherit;
          text-color = lit_inherit;
        };

        entry = {
          enabled = true;
          padding = mkLiteral "5px 0";
          background-color = lit_inherit;
          text-color = lit_inherit;
          cursor = mkLiteral "text";
          placeholder = "Search…";
          placeholder-color = lit_inherit;
        };

        num-filtered-rows = {
          enabled = true;
          expand = false;
          background-color = lit_inherit;
          text-color = lit_inherit;
        };

        textbox-num-sep = {
          enabled = true;
          expand = false;
          str = "/";
          background-color = lit_inherit;
          text-color = lit_inherit;
        };

        num-rows = {
          enabled = true;
          expand = false;
          background-color = lit_inherit;
          text-color = lit_inherit;
        };

        case-indicator = {
          enabled = true;
          background-color = lit_inherit;
          text-color = lit_inherit;
        };
        # End input bar

        # Begin listview
        listview = {
          enabled = true;
          columns = 1;
          lines = 8;
          cycle = true;
          dynamic = true;
          scrollbar = true;
          layout = mkLiteral "vertical";
          reverse = false;
          fixed-height = true;
          fixed-columns = true;
          spacing = mkLiteral "5px";
          margin = 0;
          padding = 0;
          border = mkLiteral "0px solid";
          border-radius = 0;
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-color";
          cursor = "default";
        };

        scrollbar = {
          handle-width = mkLiteral "5px";
          handle-color = mkLiteral "@handle-color";
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "@alternate-background";
        };
        # End listview

        # Begin elements
        element = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = 0;
          padding = mkLiteral "5px 10px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "10px";
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-color";
          cursor = mkLiteral "pointer";
        };

        "element normal.normal" = {
          background-color = mkLiteral "var(normal-background)";
          text-color = mkLiteral "var(normal-foreground)";
        };

        "element normal.urgent" = {
          background-color = mkLiteral "var(urgent-background)";
          text-color = mkLiteral "var(urgent-foreground)";
        };

        "element normal.active" = {
          background-color = mkLiteral "var(active-background)";
          text-color = mkLiteral "var(active-foreground)";
        };

        "element selected.normal" = {
          background-color = mkLiteral "var(selected-normal-background)";
          text-color = mkLiteral "var(selected-normal-foreground)";
        };

        "element selected.urgent" = {
          background-color = mkLiteral "var(selected-urgent-background)";
          text-color = mkLiteral "var(selected-urgent-foreground)";
        };

        "element selected.active" = {
          background-color = mkLiteral "var(selected-active-background)";
          text-color = mkLiteral "var(selected-active-foreground)";
        };

        "element alternate.normal" = {
          background-color = mkLiteral "var(alternate-normal-background)";
          text-color = mkLiteral "var(alternate-normal-foreground)";
        };

        "element alternate.urgent" = {
          background-color = mkLiteral "var(alternate-urgent-background)";
          text-color = mkLiteral "var(alternate-urgent-foreground)";
        };

        "element alternate.active" = {
          background-color = mkLiteral "var(alternate-active-background)";
          text-color = mkLiteral "var(alternate-active-foreground)";
        };

        element-icon = {
          background-color = mkLiteral "transparent";
          text-color = lit_inherit;
          size = mkLiteral "24px";
          cursor = lit_inherit;
        };

        element-text = {
          background-color = mkLiteral "transparent";
          text-color = lit_inherit;
          highlight = lit_inherit;
          cursor = lit_inherit;
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        # End elements

        # Begin mode switcher
        mode-switcher = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = 0;
          padding = 0;
          border = mkLiteral "0px solid";
          border-radius = 0;
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-color";
        };

        button = {
          padding = mkLiteral "5px 12px 5px 8px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "20px";
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "@alternate-background";
          text-color = lit_inherit;
          cursor = mkLiteral "pointer";
        };

        "button selected" = {
          background-color = mkLiteral "var(selected-normal-background)";
          text-color = mkLiteral "var(selected-normal-foreground)";
        };
        # End mode switcher

        # Begin message
        message = {
          enabled = true;
          margin = 0;
          padding = 0;
          border = mkLiteral "0px solid";
          border-radius = 0;
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-color";
        };

        textbox = {
          padding = mkLiteral "8px 10px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "10px";
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "@alternate-background";
          text-color = mkLiteral "@foreground-color";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
          highlight = mkLiteral "none";
          placeholder-color = mkLiteral "@foreground-color";
          blink = true;
          markup = true;
        };

        error-message = {
          padding = mkLiteral "10px";
          border = mkLiteral "2px solid";
          border-radius = mkLiteral "10px";
          border-color = mkLiteral "@border-color";
          background-color = mkLiteral "@background-color";
          text-color = mkLiteral "@foreground-color";
        };
        # End message
      };
  };
}
