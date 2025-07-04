{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        height = 23;
        margin = "0";
        spacing = 10;
        border-size = 2;
        padding = "10";
        position = "top";

        modules-left = [
          "custom/files"
        ];
        modules-center = [ ];
        modules-right = [
          "battery"
          "clock"
        ];

        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capcity}% 🔋";
          format-plugged = "{capacity}% 🔌";

          states = {
            critical = 15;
            warning = 30;
          };
        };

        clock = {
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };

        network = {
          interval = 1;
          format-disconnected = "";
        };

        "custom/files" = {
          exec = "echo 'File'";
          interval = 60;
          return-type = "plain";
          on-click = "nautilus";
        };

        "custom/help" = {
          exec = "echo 'Help'";
          interval = 60;
          return-type = "plain";
          on-click = "niri msg action show-hotkey-overlay";
        };
      }
    ];
  };
}
