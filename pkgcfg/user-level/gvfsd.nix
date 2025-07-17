{ pkgs, ... }:
{
  # Gnome virtual file system daemon
  # Associated with dependency gnome.gvfs
  # Allows nautilus to use SMB to NAS

  systemd.user.services = {
    gvfsd = {
      Unit = {
        Description = "GVFS Daemon";
        After = [ "dbus.service" ];
      };

      Install = {
        WantedBy = [ "default.target" ];
      };

      Service = {
        ExecStart = "${pkgs.gnome.gvfs}/libexec/gvfsd";
        Restart = "on-failure";
      };
    };

    gvfsd-smb = {
      Unit = {
        Description = "GVFS SMB Daemon";
        After = [ "gvfsd.service" ];
      };

      Install = {
        WantedBy = [ "default.target" ];
      };

      Service = {
        ExecStart = "${pkgs.gnome.gvfs}/libexec/gvfsd-smb";
        Restart = "on-failure";
      };
    };

    gvfsd-fuse = {
      Unit = {
        Description = "GVFS FUSE Daemon";
        After = [ "gvfsd.service" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };

      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p %h/.gvfs"; # create mount point
        ExecStart = "${pkgs.gnome.gvfs}/libexec/gvfsd-fuse %h/.gvfs";
        Restart = "on-failure";
      };
    };
  };
}
