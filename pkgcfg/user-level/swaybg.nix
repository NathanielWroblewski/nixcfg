{ config, pkgs, ... }:
{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper Background Service";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.swaybg}/bin/swaybg -m fill -i "${config.home.homeDirectory}/Pictures/.background-image.jpg"
      '';
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
