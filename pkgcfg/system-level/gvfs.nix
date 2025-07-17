{ pkgs, lib, ... }:
{
  # gnome virtual file system
  # this is used in conjunction with samba to allow
  # nautilus to access the NAS
  services.gvfs.enable = true;

  environment.sessionVariables = {
    GIO_EXTRA_MODULES = lib.mkForce "${pkgs.gnome.gvfs}/lib/gio/modules";
  };

  systemd.user.extraConfig = ''
    Environment=GIO_EXTRA_MODULES=${pkgs.gnome.gvfs}/lib/gio/modules:${pkgs.dconf}/lib/gio/modules
  '';
}
