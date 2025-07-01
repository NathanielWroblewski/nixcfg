{ ... }:
{
  programs.yazi = {
    enable = true;

    # more settings detailed here: https://yazi-rs.github.io/docs/configuration/yazi/
    settings = {

      # file explorer pane
      manager = {
        ratio = [
          2 # parent: 2/8th
          2 # current: 2/8ths
          4 # preview: 4/8ths
        ];

        sort_by = "natural"; # alphabetical with proper sorting for 1.md, 10.md, 2.md etc
        sort_sensitive = true; # case-sensitive sort
        sort_reverse = false;
        sort_dir_first = true; # lift directories
        sort_translit = true; # transliterate hungarian characters etc into english characters

        linemode = "none"; # display info associated with the file on the right side of the file list row

        show_hidden = true; # display hidden files
        show_symlink = true;

        mouse_events = [
          "click"
          "scroll"
        ];
      };

      # preview pane
      preview = {
        wrap = "yes"; # wrap long lines
        tab_size = 2; # convert tabs to this # of spaces
        max_width = 100; # max preview width
      };

      # configure applications used to open file types
      opener = {
        edit = [
          { run = "$EDITOR \"$@\""; block = true; for = "linux"; }
        ];
      };

      # rules when opening files
      open = {
        prepend_rules = [
          { name = "*.json"; use = "edit"; }
          { name = "*.nix"; use = "edit"; }
          { name = "*.js"; use = "edit"; }
          { name = "*.ts"; use = "edit"; }
          { name = "*.yaml"; use = "edit"; }
          { name = "*.toml"; use = "edit"; }
          { name = "*.zsh"; use = "edit"; }
          { name = "*.sh"; use = "edit"; }
        ];
      };
    };
  };
}
