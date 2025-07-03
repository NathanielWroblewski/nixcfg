# Home manager configuration common across all hosts/devices

{ inputs, outputs, constants, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # Allows home manager to install software per user
    useUserPackages = true;

    # Passes inputs, outputs, and constants into home manager configs for re-use without re-importing
    extraSpecialArgs = { inherit inputs outputs constants; };
  };
}
