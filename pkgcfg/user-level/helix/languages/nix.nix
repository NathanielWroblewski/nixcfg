{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.features.editor.helix.nix;
in
{
  options.features.editor.helix.nix.enable = mkEnableOption "Enable nix lsp for helix";
  config = mkIf cfg.enable {

    programs.helix = {
      languages = {
        language = [{
          name = "nix";
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }];
      };
      extraPackages = with pkgs; [
        nil
        nixd
        nixpkgs-fmt
      ];
    };
  };
}
