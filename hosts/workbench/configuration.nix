# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# Preserves the original configuration.nix and hardware-configuration files
# created by a vanilla NixOS installation.
{ pkgs, ... }:
let
  pkgsets = import ../../pkgsets/system-level/default.nix { inherit pkgs; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Bootloader and setup
      ../../syscfg/shared/bootloader.nix
      ../../syscfg/shared/region.nix
      ../../syscfg/workbench/firmware-updater.nix

      # Drivers and devices
      ../../syscfg/shared/drivers.nix
      ../../syscfg/shared/audio.nix
      ../../syscfg/shared/keyboard.nix
      ../../syscfg/shared/printer.nix
      ../../syscfg/shared/trackpad.nix
      ../../syscfg/shared/bluetooth.nix

      # Networking
      ../../syscfg/shared/networking.nix
      ../../syscfg/workbench/networking.nix
      ../../syscfg/shared/firewall.nix
      ../../syscfg/shared/ssh.nix

      # Peripheral support
      ../../syscfg/workbench/wireplumber.nix # elgato wave 3 microphone support
      ../../syscfg/workbench/thunderbolt.nix # caldigit TS4 over thunderbolt cxn

      # Theme
      ../../syscfg/shared/fonts.nix

      # Device-specific NixOS configuration
      ../../syscfg/workbench/nixos.nix

      # Device-specific desktop environment
      ../../syscfg/workbench/desktop.nix

      # Device-level package configuration
      ../../pkgcfg/system-level/1pass.nix # password manager
      ../../pkgcfg/system-level/avahi.nix # auto-discovery of wireless network printers etc
      ../../pkgcfg/system-level/gvfs.nix # gnome virtual file system, allows nautilus to access NAS
      ../../pkgcfg/system-level/niri.nix # wayland compositor, tiling window manager
      ../../pkgcfg/system-level/polkit.nix # enable policy kit back-end
      ../../pkgcfg/system-level/steam.nix # steam & gamescope for gaming
      ../../pkgcfg/system-level/stylix.nix # themeing
      ../../pkgcfg/system-level/tailscale.nix # mesh vpn
      ../../pkgcfg/system-level/tuigreet.nix # display manager and login
      ../../pkgcfg/system-level/sabnzbd.nix # usenet reader
      ../../pkgcfg/system-level/zsh.nix # shell
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    pkgsets.credentials ++
    pkgsets.gaming ++
    pkgsets.nas ++
    pkgsets.networking ++
    pkgsets.peripherals ++
    pkgsets.shell ++
    pkgsets.themes ++
    pkgsets.usenet ++
    pkgsets.wayland ++
    [ ];
}
