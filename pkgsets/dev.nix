{ pkgs, ... }: {
  packages = with pkgs; [
    alacritty # terminal
    wezterm # terminal emulator
    ripgrep
    starship # cli prompt
    yazi # terminal file manager
    lutgen # apply color themes to images
  ];
}
