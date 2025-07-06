{ config, pkgs, inputs, constants, ... }:
let
  users = constants.users;
in
{
  users.users.nathaniel = {
    initialHashedPassword = "$y$j9T$ddxjoTt2s2kSuZIP0xTXG1$ohF57.TzjtXNpZ9SPaNGSvoM1pZ99ivx5XY48Rul8jB";
    isNormalUser = true;
    description = users.nathaniel;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [ ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager.users.nathaniel = import ../../../home/${users.nathaniel}/${config.networking.hostName}.nix;
}
