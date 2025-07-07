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

        adjust_window_size_when_changing_font_size = false,
        enable_scroll_bar = true,
        enable_wayland = true,
        hide_tab_bar_if_only_one_tab = true,
        initial_cols = 100,
        kde_window_background_blur = true,
        mouse_wheel_scrolls_tabs = false,
        scrollback_lines = 10000,

        keys = {
          {
            key = 'c',
            mods = 'CMD',
            action = wezterm.action.CopyTo 'Clipboard',
          },
          {
            key = 'v',
            mods = 'CMD',
            action = wezterm.action.PasteFrom 'Clipboard',
          },
        },
      }
    '';
  };
}
