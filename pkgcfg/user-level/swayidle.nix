{ pkgs, ... }:
{
  systemd.user.services.swayidle = {
    Unit = {
      Description = "Wayland idle manager";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      # After 10 minutes of inactivity, power off monitors and lock screen
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 601 'niri msg action power-off-monitors' \
          timeout 600 'swaylock -f' \
          before-sleep 'swaylock -f'
      '';
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
