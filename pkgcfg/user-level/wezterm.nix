{ constants, ... }:
let
  theme = constants.themes.colors.active;
  fonts = constants.themes.fonts;
in
{
  programs.wezterm = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;

    extraConfig = ''
      return {
        color_scheme = '${theme.name.titleized}', 
        font = wezterm.font('${fonts.mono}'),
        window_background_opacity = 0.85,

        hide_tab_bar_if_only_one_tab = true
      }
    '';
  };
}
