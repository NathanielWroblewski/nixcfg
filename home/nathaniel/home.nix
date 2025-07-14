{ config, lib, pkgs, constants, ... }:
let
  users = constants.users;
  userPackageList = import ../../pkgsets/user.nix { pkgs = pkgs; };
  devPackageList = import ../../pkgsets/dev.nix { pkgs = pkgs; };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = lib.mkDefault users.nathaniel;
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages =
    userPackageList.packages ++
    devPackageList.packages ++
    [ ];

  # Slightly modified from /hosts/shares/nix.nix for user-level
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  imports = [
    # Reiterate system-level nixpkg config
    ../../hosts/shared/nixpkgs.nix

    # Import user-level package configurations
    ../../pkgcfg/user-level/fonts.nix
    ../../pkgcfg/user-level/fuzzel.nix
    ../../pkgcfg/user-level/git.nix
    ../../pkgcfg/user-level/gtk.nix
    ../../pkgcfg/user-level/helix/default.nix
    ../../pkgcfg/user-level/keybase.nix
    ../../pkgcfg/user-level/librewolf.nix
    ../../pkgcfg/user-level/niri.nix
    ../../pkgcfg/user-level/stylix.nix
    ../../pkgcfg/user-level/swaybg.nix
    ../../pkgcfg/user-level/swayidle.nix
    ../../pkgcfg/user-level/waybar.nix
    ../../pkgcfg/user-level/wezterm.nix
    ../../pkgcfg/user-level/yazi.nix
    ../../pkgcfg/user-level/zsh.nix
  ];

  # home.file = {
  #   Building this configuration will create a copy of dotfiles/screenrc in
  #   the Nix store. Activating the configuration will then make ~/.screenrc a
  #   symlink to the Nix store copy.
  #   ".screenrc".source = dotfiles/screenrc;

  #   You can also set the file content immediately.
  #   ".gradle/gradle.properties".text = 
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000;
  # };

  home.sessionVariables = {
    TERMINAL = "wezterm";
    EDITOR = "hx";
  };

  home.file."bin/wifi" = {
    text = builtins.readFile ../../scripts/wifi.sh;
    executable = true;
  };

  home.file."bin/sound" = {
    text = builtins.readFile ../../scripts/sound.sh;
    executable = true;
  };
}
