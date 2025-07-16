{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # `$ nix search wget`
  packages = with pkgs; [
    zsh # shell
    tmux # terminal multiplexer/window management
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
  ];
}
