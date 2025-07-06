{ pkgs, lib, constants, ... }:
let
  trim = lib.strings.trim;
  themeFonts = constants.themes.fonts;
in
{
  cmd = trim ''
    ${pkgs.swaylock-effects}/bin/swaylock -f \
      --bs-hl-color ffffffff \
      --clock \
      --daemonize \
      --effect-blur 15x8 \
      --effect-vignette 0.3:0.3 \
      --fade-in 1 \
      --font "${themeFonts.sans}" \
      --ignore-empty-password \
      --image /home/nathaniel/Pictures/.background-image.jpg \
      --indicator \
      --indicator-caps-lock \
      --indicator-idle-visible \
      --indicator-radius 120 \
      --indicator-thickness 7 \
      --inside-clear-color 34c75940 \
      --inside-color 00000040 \
      --inside-ver-color 00000020 \
      --inside-wrong-color ff3b3040 \
      --key-hl-color ffffffff \
      --line-clear-color 00000000 \
      --line-color 00000000 \
      --line-wrong-color 00000000 \
      --ring-clear-color 34c759 \
      --ring-color d0d0d0 \
      --ring-ver-color ffffff \
      --ring-wrong-color ff3b30 \
      --separator-color 00000000 \
      --show-failed-attempts \
      --text-clear-color ffffff \
      --text-color ffffff \
      --text-ver-color ffffff \
      --text-wrong-color ffffff      
  '';
}
