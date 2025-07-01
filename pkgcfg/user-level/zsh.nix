{
  programs.zsh = {
    # For the system-level configuration options, see the other zsh definition.

    # The user-level configuration options are available at
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable

    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };

    shellAliases = {
      ll = "ls -l";
    };

    # dotDir = ../dotfiles;

    history = {
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 10000;
      saveNoDups = true;
      share = true;
      size = 10000;
    };
  };
}
