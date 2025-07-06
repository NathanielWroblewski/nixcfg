{ pkgs, lib, constants, ... }:
let
  trim = lib.strings.trim;
  fonts = constants.themes.fonts;
  colors = constants.themes.colors.active;
  users = constants.users;
in
{
  cmd = trim ''
    ${pkgs.swaylock-effects}/bin/swaylock -f \
      --bs-hl-color ${colors.primary.foreground} \
      --clock \
      --daemonize \
      --datestr "%A, %B %d" \
      --effect-blur 15x8 \
      --effect-vignette 0.3:0.3 \
      --fade-in 1 \
      --font "${fonts.sans}" \
      --ignore-empty-password \
      --image /home/${users.nathaniel}/Pictures/.background-image.jpg \
      --indicator \
      --indicator-caps-lock \
      --indicator-idle-visible \
      --indicator-radius 120 \
      --indicator-thickness 7 \
      --inside-clear-color 00000000 \
      --inside-color 00000000 \
      --inside-ver-color 00000000 \
      --inside-wrong-color 00000000 \
      --key-hl-color ${colors.primary.foreground} \
      --line-clear-color 00000000 \
      --line-color 00000000 \
      --line-ver-color 00000000 \
      --line-wrong-color 00000000 \
      --ring-clear-color ${colors.primary.foreground} \
      --ring-color ${colors.primary.foreground} \
      --ring-ver-color ${colors.primary.foreground} \
      --ring-wrong-color ${colors.normal.red} \
      --separator-color 00000000 \
      --text-clear-color ${colors.primary.foreground} \
      --text-color ${colors.primary.foreground} \
      --text-ver-color ${colors.primary.foreground} \
      --text-wrong-color ${colors.primary.foreground} \
      --timestr "%I:%M %p"      
  '';
}
