{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # `$ nix search wget`
  packages = with pkgs; [
    tailscale
    teamspeak6-client
  ];
}
