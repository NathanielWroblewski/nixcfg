{ pkgs, ... }:
{
  credentials = import ./credentials.nix { inherit pkgs; };
  gaming = import ./gaming.nix { inherit pkgs; };
  nas = import ./nas.nix { inherit pkgs; };
  networking = import ./networking.nix { inherit pkgs; };
  peripherals = import ./peripherals.nix { inherit pkgs; };
  shell = import ./shell.nix { inherit pkgs; };
  themes = import ./themes.nix { inherit pkgs; };
  wayland = import ./wayland.nix { inherit pkgs; };
}

