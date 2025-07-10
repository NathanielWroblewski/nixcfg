{
  description = "top-level NixOS configuration";

  # inputs lists external flakes this flake depends on
  inputs = {
    # home manager allows for declaratively configuring user-specific packages and dotfiles using nix
    home-manager = {
      url = "github:nix-community/home-manager"; # where to pull the flake from
      inputs.nixpkgs.follows = "nixpkgs"; # tells home manager to use the same version of nixpkgs defined below
    };

    # catppuccin.url = github:catppuccin/nix;              # themes for apps/desktop

    # themes for appls/desktops
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs is the main source for nix packages, pins to unstable for latest
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # a secondary version is specified to allow for specifying the latest stable release
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # apple fonts, requires stylix
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs receives all inputs as well as self (this flake) and defines what this flake exposes
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # create a per-system set of packages
      packages =
        forAllSystems (system: import ./deps/imports nixpkgs.legacyPackages.${system});

      # overlays let you customize or extend nixpkgs
      overlays = import ./deps/overlays { inherit inputs; };

      # helper to build a full NixOS system configuration
      nixosConfigurations = {

        # defines a NixOS configuration named "slab" for my slab device (Khadas Mind 2S)
        slab = nixpkgs.lib.nixosSystem {
          # special args will be available in the inputs to downstream expressions/nix-files without having to index on config, etc.
          # they are passed directly to each nix module in the modules list below
          # you can access inputs, outputs, and constants in any of the nix modules without re-importing them again
          specialArgs = {
            inherit inputs outputs;
            constants = {
              filepaths = import ./constants/filepaths.nix;
              users = import ./constants/users.nix;
              themes = {
                fonts = import ./constants/themes/fonts.nix;
                colors = import ./constants/themes/colors.nix;
              };
            };
          };

          # modules placed here can be accessed via the config argument on downstream expressions/nix-files
          # modules are typically a list of .nix files that define the actual system configuration
          modules = [
            inputs.stylix.nixosModules.stylix
            ./hosts/slab
          ];
        };
      };
    };
}
