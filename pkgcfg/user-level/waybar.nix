{ pkgs, ... }:
let
  home = builtins.getEnv "HOME";
in
{
  # File | Help
  # notifications | microphone | speakers | bluetooth | ethernet/wifi | battery | date | clock
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style =
      (builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css") +
      (builtins.readFile ../../stylesheets/waybar.css);

    settings = [
      {
        layer = "top";
        position = "top";
        height = 23;
        spacing = 10;
        border-size = 2;
        padding = 10;

        icon-theme = "WhiteSur";

        modules-left = [
          "image/nixos"
          "custom/textone"
          "custom/texttwo"
        ];
        modules-center = [ ];
        modules-right = [
          "image#ethernetart"
          "battery"
          "custom/date"
          "clock"
        ];

        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capcity}% {icon}";
          format-plugged = "{capacity}% {icon}";
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
          exec = "date '+%a %d %b'";
          interval = 60;
          tooltip = false;
        };

        network = {
          interval = 1;
          format-disconnected = "";
        };

        "image/nixos" = {
          path = "/home/nathaniel/Pictures/icons/nix-snowflake-white.png";
          interval = 60;
          size = 13;
        };

        "custom/textone" = {
          exec = "echo 'File'";
          interval = 60;
          return-type = "plain";
          on-click = "nautilus";
        };

        "custom/texttwo" = {
          exec = "echo 'Help'";
          interval = 60;
          return-type = "plain";
          on-click = "niri msg action show-hotkey-overlay";
        };

        "image#ethernetart" = {
          path = "/home/nathaniel/Pictures/icons/wifi-white.png";
          size = 13;
          interval = 60;
        };
      }
    ];
  };
}
