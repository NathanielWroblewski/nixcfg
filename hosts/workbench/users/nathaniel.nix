{ config, pkgs, inputs, constants, ... }:
let
  users = constants.users;
in
{
  users.users.nathaniel = {
    initialHashedPassword = "$y$j9T$R.S/AvpTloUNYBFHKU0eL/$Y5p8CKUwzL6fAdKg9xpBqUXt6/mpykg6pQG2ihjVxP9";
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
