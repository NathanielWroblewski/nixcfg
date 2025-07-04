# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# Preserves the original configuration.nix and hardware-configuration files
# created by a vanilla NixOS installation.
{ pkgs, ... }:
let
  desktopPkgs = import ../../pkgsets/desktop.nix { pkgs = pkgs; };
  globalPkgs = import ../../pkgsets/global.nix { pkgs = pkgs; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Bootloader and setup
      ../../syscfg/shared/bootloader.nix
      ../../syscfg/shared/region.nix

      # Drivers and devices
      ../../syscfg/shared/xwayland.nix
      ../../syscfg/shared/drivers.nix
      ../../syscfg/shared/audio.nix
      ../../syscfg/shared/keyboard.nix
      ../../syscfg/shared/printer.nix
      ../../syscfg/shared/trackpad.nix

      # Networking
      ../../syscfg/shared/networking.nix
      ../../syscfg/shared/firewall.nix
      ../../syscfg/shared/ssh.nix

      # Theme
      ../../syscfg/shared/fonts.nix

      # Device-specific NixOS configuration
      ../../syscfg/slab/nixos.nix

      # Device-specific desktop environment
      ../../syscfg/slab/desktop.nix

      # Device-level package configuration
      ../../pkgcfg/system-level/1pass.nix # password manager
      ../../pkgcfg/system-level/niri.nix # wayland compositor, tiling window manager
      ../../pkgcfg/system-level/tuigreet.nix # display manager and login
      ../../pkgcfg/system-level/zsh.nix # shell
      # ../../pkgcfg/system-level/docker.nix
      # ../../pkgcfg/system-level/hyprland.nix
      # ../../pkgcfg/system-level/polkit.nix
      # ../../pkgcfg/system-level/gpg.nix
      # ../../pkgcfg/system-level/steam.nix
      # ../../pkgcfg/system-level/niri.nix
      # ../../pkgcfg/system-level/uwsm.nix
    ];

  boot.initrd.luks.devices."luks-b99c70c5-5131-45b2-a318-88efa944325d".device = "/dev/disk/by-uuid/b99c70c5-5131-45b2-a318-88efa944325d";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    desktopPkgs.wayland.niri.packages ++
    globalPkgs.packages ++ [
      xclip # clipboard
      wl-clipboard # wayland clipboard, allows copying from terminal ctrl+shift+c 
      usbutils # for troubleshooting the Dock peripheral
      pciutils # for troubleshooting the Dock peripheral
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
}
