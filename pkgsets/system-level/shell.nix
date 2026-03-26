{ pkgs, ... }: with pkgs; [
  # List packages installed in system profile. To search, run:
  # `$ nix search wget`
  zsh # shell
  git # version control
  neovim # text editor
  helix # text editor
  bottom # htop descendant
]
