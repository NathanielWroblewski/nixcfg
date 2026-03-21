{
  imports = [
    # Import conifguration common across all devices
    ../shared

    # Import device-specific configuration
    ./configuration.nix

    # import host's users
    ./users/default.nix
  ];
}
