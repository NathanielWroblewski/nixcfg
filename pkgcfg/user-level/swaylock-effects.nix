{ pkgs, lib, constants, ... }:
let
  trim = lib.strings.trim;
  hex_to_rgb = str: lib.replaceStrings [ "#" ] [ "" ] str;

  fonts = constants.themes.fonts;
  theme = constants.themes.colors.active;
  paths = constants.filepaths;

  foreground = hex_to_rgb theme.primary.foreground;
  red = hex_to_rgb theme.normal.red;
  transparent = "00000000";
in
{
  cmd = trim ''
    ${pkgs.swaylock-effects}/bin/swaylock -f \
      --bs-hl-color ${foreground} \
      --clock \
      --daemonize \
      --datestr "%A, %B %d" \
      --effect-blur 15x8 \
      --effect-vignette 0.3:0.3 \
      --fade-in 1 \
      --font "${fonts.sans}" \
      --grace 1 \
      --ignore-empty-password \
      --image "${paths.background_image}" \
      --indicator-caps-lock \
      --indicator-idle-visible \
      --indicator-radius 120 \
      --indicator-thickness 7 \
      --inside-clear-color ${transparent} \
      --inside-color ${transparent} \
      --inside-ver-color ${transparent} \
      --inside-wrong-color ${transparent} \
      --key-hl-color ${foreground} \
      --line-clear-color ${transparent} \
      --line-color ${transparent} \
      --line-ver-color ${transparent} \
      --line-wrong-color ${transparent} \
      --ring-clear-color ${foreground} \
      --ring-color ${foreground} \
      --ring-ver-color ${foreground} \
      --ring-wrong-color ${red} \
      --separator-color ${transparent} \
      --text-clear-color ${foreground} \
      --text-color ${foreground} \
      --text-ver-color ${foreground} \
      --text-wrong-color ${foreground} \
      --timestr "%I:%M %p"      
  '';
}
