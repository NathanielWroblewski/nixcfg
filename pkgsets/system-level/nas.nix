{ pkgs, ... }: with pkgs; [
  samba # for SMB into NAS, provides smbclient/smbtree, etc
  gnome.gvfs # for Nautilus to discover and mount SMB shares
]
