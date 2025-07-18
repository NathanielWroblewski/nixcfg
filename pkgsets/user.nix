{ pkgs, ... }: {
  packages = with pkgs; [
    polkit_gnome # policy kit client/agent for authorization
    pavucontrol # audio settings gui
    librewolf # browser
    vlc # media player
    _1password-gui # password manager application
    _1password-cli # password manager cli
    keybase # encrypted messaging app's cli
    keybase-gui # encrypted messaging app
    telegram-desktop # encrypted messaging app
    slack # messaging app
    marktext # markdown previewer/editor for note taking
  ];
}
