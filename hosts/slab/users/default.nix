{ pkgs, ... }:
{
  imports = [ ./nathaniel.nix ];

  # Set default shell
  users.defaultUserShell = pkgs.zsh;
}
