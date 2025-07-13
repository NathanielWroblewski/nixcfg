{
  programs.zsh = {
    # For the system-level configuration options, see the other zsh definition.

    # The user-level configuration options are available at
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable

    enable = true;

    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };

    # Syntax highlighting breaks terminal ligatures unless quoted, see:
    # https://github.com/wezterm/wezterm/issues/2331#issuecomment-1200560007
    # and https://github.com/zsh-users/zsh-syntax-highlighting/issues/750
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };

    # add content to .zshrc
    initContent = builtins.readFile ../../dotfiles/zshrc.zsh;

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
