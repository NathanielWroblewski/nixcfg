# Nix configuration shared across all hosts/devices

{ lib, inputs, constants, ... }:
let
  users = constants.users;
in
{
  nix = {
    settings = {
      # Enables flakes and new CLI (`nix` instead of `nix-env`)
      experimental-features = "nix-command flakes";

      # Users allowed to use the flake command
      trusted-users = [
        users.root
        users.nathaniel
      ];
    };

    # Garbage collection configuration
    gc = {
      automatic = true;
      options = "--delete-older-than 30d"; # will not garbage collection active configuration
    };

    # Deduplicate files in nix store
    optimise.automatic = true;

    # Automatically register flake inputs as Nix registry entries
    # Allows `nix run home-manager` instead of `github:nix-community/home-manager`
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    # Compatibility layer for tools expecting a legacy `nixPath` like `nix-shell`
    nixPath = [ "/etc/nix/path" ];
  };
}
