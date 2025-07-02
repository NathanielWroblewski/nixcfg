{ pkgs, ... }: {
  packages = with pkgs; [
    brave # browser
    vlc # media player
    keybase # encrypted chat cli
    keybase-gui # encrypted chat app
    _1password-gui # password manager application
    _1password-cli # password manager cli
    slack # chat app
    zettlr # markdown previewer/editor for note taking
  ];
}
