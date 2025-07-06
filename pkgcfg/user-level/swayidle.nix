{ pkgs, lib, constants, ... }:
let
  timeout = 30; # 10 minutes
  swaylock = import ./swaylock-effects.nix {
    pkgs = pkgs;
    lib = lib;
    constants = constants;
  };
in
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
          timeout ${toString (timeout + 1)} 'niri msg action power-off-monitors' \
          timeout ${toString timeout} '${swaylock.cmd}' \
          before-sleep '${swaylock.cmd}'
      '';
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
