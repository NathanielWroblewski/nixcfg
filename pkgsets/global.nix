{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # `$ nix search wget`
  packages = with pkgs; [
    zsh # shell
    git # version control

    neovim # text editor
    helix # text editor

    htop # resources
    unzip # unarchive
    jq # query JSON
    tree # crawl a directory

    # curl is pre-installed.
    # gawk is pre-installed.
    # sed is pre-installed.

    # fonts
    noto-fonts-emoji # emojis

    # NAS
    samba # for SMB into NAS, provides smbclient/smbtree, etc
    gnome.gvfs # for Nautilus to discover and mount SMB shares
  ];
}
