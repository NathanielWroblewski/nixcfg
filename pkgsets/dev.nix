{ pkgs, ... }: {
  packages = with pkgs; [
    wezterm # terminal emulator
    ripgrep
    starship # cli prompt
    yazi # terminal file manager
    lutgen # apply color themes to images
    ffmpeg
  ];
}
