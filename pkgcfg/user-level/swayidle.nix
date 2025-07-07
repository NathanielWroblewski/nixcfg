{ pkgs, lib, constants, ... }:
let
  escape = str:
    lib.pipe str [
      (lib.replaceStrings [ "%" ] [ "%%" ])
      (lib.replaceStrings [ "%%h" ] [ "%h" ])
    ];

  lock_timeout = 600; # 10 minutes
  sleep_timeout = lock_timeout + 30; # when monitor powers off

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
          timeout ${toString sleep_timeout} 'niri msg action power-off-monitors' \
          timeout ${toString lock_timeout} '${escape swaylock.cmd}' \
          before-sleep '${escape swaylock.cmd}'
      '';
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
