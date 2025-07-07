{ pkgs, ... }:
{
  systemd.user.services.mpvpaper = {
    Unit = {
      Description = "Set a movie wallpaper";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.mpvpaper}/bin/mpvpaper ALL -o "--no-audio --loop-file=inf --speed=1" \
          /home/nathaniel/Pictures/.background-video.mp4
      '';
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
