{ constants, ... }:
let
  fonts = constants.themes.fonts;
  colors = constants.themes.colors.active;
in
{
  # For configuration options, see: https://github.com/Alexays/Waybar/wiki/Configuration

  # File | Help
  # notifications | microphone | speakers | bluetooth | ethernet/wifi | battery | date | clock
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    # can revert to original stylesheet with:
    # builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"
    style = ''
      * {
          font-family: "${fonts.sans}", sans-serif;
          font-size: 14px;
          transition: background-color .3s ease-out;
          font-weight: 700;
      }

      window#waybar {
          background: ${colors.primary.background};
          color: ${colors.bright.white};
          transition: background-color .5s;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          margin: 5px 10px;
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #custom-textone,
      #custom-texttwo,
      #custom-textthree,
      #tray {
          padding: 0 10px;
      }
    '';
    settings = [
      {
        layer = "top"; # waybar sits at topmost layer
        position = "top"; # waybar positioned at top of screen
        height = 23;
        spacing = 10; # Spacing between modules defined below
        # border-size = 2;
        padding = 10;

        icon-theme = "WhiteSur";

        modules-left = [
          "custom/textone"
          "custom/texttwo"
          "custom/textthree"
        ];
        modules-center = [ ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "custom/date"
          "clock"
        ];

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%  {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          on-click = "sh ~/scripts/rofi-wifi-menu/rofi-wifi-menu.sh";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-alt = "{time} {icon}";
          format-charging = "{icon} {capacity}%";
          format-plugged = "{icon} {capacity}%";
          format-icons = [ "" "" "" "" "" ];

          states = {
            critical = 15;
            warning = 30;
          };
        };

        clock = {
          format = "{:%I:%M %p}";
        };

        "custom/date" = {
          exec = "date '+%a %b %d'";
          interval = 60;
          tooltip = false;
        };

        "custom/textone" = {
          exec = "echo 'λ'";
          interval = 60;
          return-type = "plain";
          on-click = ""; # add logout, restart etc
        };

        "custom/texttwo" = {
          exec = "echo 'File'";
          interval = 60;
          return-type = "plain";
          on-click = "nautilus";
        };

        "custom/textthree" = {
          exec = "echo 'Help'";
          interval = 60;
          return-type = "plain";
          on-click = "niri msg action show-hotkey-overlay";
        };
      }
    ];
  };
}
