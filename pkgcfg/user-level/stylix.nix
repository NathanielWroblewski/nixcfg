{ pkgs, ... }: {
  stylix = {
    # targets are enumerated here: https://github.com/nix-community/stylix/tree/master/modules
    targets = {
      gtk.enable = false;
      helix.enable = false;
      wezterm.enable = false;

      librewolf = {
        enable = false;
        # profileNames = [];
        # colorTheme.enable = true;
      };
    };

    polarity = "light";

    # iconTheme = {
    #   enable = true;
    #   package = pkgs.whitesur-icon-theme;
    #   # find theme name in /run/current-system/sw/share/icons
    #   dark = "WhiteSur-dark";
    #   light = "WhiteSur-light";
    # };

    # find the cursors located at /run/current-system/sw/share/icons
    cursor = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
      size = 48;
    };
  };
}
