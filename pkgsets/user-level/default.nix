{ pkgs, ... }:
{
  chat = import ./chat.nix { inherit pkgs; };
  desktop = import ./desktop.nix { inherit pkgs; };
  dev = import ./dev.nix { inherit pkgs; };
  retroGaming = import ./retro-gaming.nix { inherit pkgs; };
  user = import ./user.nix { inherit pkgs; };
}

