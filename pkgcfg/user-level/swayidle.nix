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
          timeout 600 'swaylock -f --screenshots --clock --indicator --indicator-radius 100 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.2' \
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
