{ pkgs, ... }:
{
  programs.zsh = {
    # The full list of conifuguration options at the system-level can be found with
    # `$ nixos-option programs.zsh`
    #
    # For the user-level configuration options, see the other zsh definition.

    enable = true;

    enableCompletion = true;
    autosuggestions.enable = true;
    enableLsColors = true;

    # Syntax highlighting breaks terminal ligatures unless quoted, see:
    # https://github.com/wezterm/wezterm/issues/2331#issuecomment-1200560007
    # and https://github.com/zsh-users/zsh-syntax-highlighting/issues/750
    syntaxHighlighting.enable = true;

    promptInit =
      if (pkgs.starship or null) != null
      then ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      ''
      else null;

    # shellAliases = {
    #   ll = "ls -l";
    # };

    # dotDir = ../dotfiles;

    # history = {
    #   ignoreAllDups = true;
    #   ignoreSpace = true;
    #   save = 10000;
    #   saveNoDups = true;
    #   share = true;
    #   size = 10000;
    # };
  };
}
