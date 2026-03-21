{ pkgs, ... }:
{
  packages = with pkgs; [
    # solaar # logitech mx master mouse
    bolt # thunderbolt daemon, boltctl, caldigit ts4
  ];
}
