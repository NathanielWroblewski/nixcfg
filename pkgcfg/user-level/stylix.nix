{ pkgs, ... }: {
  stylix = {
    # targets are enumerated here: https://github.com/nix-community/stylix/tree/master/modules
    targets = {
      gtk.enable = false;
      helix.enable = false;
      wezterm.enable = false;
    };

    polarity = "light";

    # iconTheme = {
    #   enable = true;
    #   package = pkgs.whitesur-icon-theme;
    #   # find theme name in /run/current-system/sw/share/icons
    #   dark = "WhiteSur-dark";
    #   light = "WhiteSur-light";
    # };
  };
}
