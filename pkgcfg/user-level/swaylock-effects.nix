{ pkgs, lib, constants, ... }:
let
  trim = lib.strings.trim;
  themeFonts = constants.themes.fonts;
in
{
  cmd = trim ''
    ${pkgs.swaylock-effects}/bin/swaylock -f \
      --image /home/nathaniel/Pictures/.background-image.jpg \
      --font "${themeFonts.sans}" \
      --clock \
      --indicator \
      --indicator-radius 120 \
      --indicator-thickness 7 \
      --effect-blur 15x8 \
      --effect-vignette 0.3:0.3 \
      --fade-in 1 \
      --ring-color d0d0d0 \
      --ring-ver-color ffffff \
      --ring-wrong-color ff3b30 \
      --ring-clear-color 34c759 \
      --inside-color 00000040 \
      --inside-ver-color 00000020 \
      --inside-wrong-color ff3b3040 \
      --inside-clear-color 34c75940 \
      --separator-color 00000000 \
      --line-color 00000000 \
      --line-clear-color 00000000 \
      --line-wrong-color 00000000 \
      --key-hl-color ffffffff \
      --bs-hl-color ffffffff \
      --text-color ffffff \
      --text-clear-color ffffff \
      --text-ver-color ffffff \
      --text-wrong-color ffffff
  '';
}
