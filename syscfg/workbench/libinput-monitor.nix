{ pkgs, ... }:
{

  systemd.services.libinput-log = {
    description = "libinput debug event logger";
    wantedBy = [ "multi-user.target" ];
    path = [
      pkgs.libinput
      pkgs.gnugrep
      pkgs.bash
    ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'libinput debug-events 2>&1 | grep --line-buffered -E \"KEY_|BTN_\" >> /var/log/libinput-debug.log'";
      Restart = "always";
      RestartSec = "3s";
    };
  };

  services.logrotate = {
    enable = true;
    settings = {
      "/var/log/libinput-debug.log" = {
        size = "2G";
        rotate = 2;
        compress = true;
        delaycompress = true;
        missingok = true;
        notifempty = true;
        postrotate = "systemctl restart libinput-log";
      };
    };
  };
}
