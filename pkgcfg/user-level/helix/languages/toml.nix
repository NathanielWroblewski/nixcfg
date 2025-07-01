{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.features.editor.helix.toml;
in
{
  options.features.editor.helix.toml.enable = mkEnableOption "Enable toml lsp for helix";
  config = mkIf cfg.enable {

    programs.helix = {
      languages = {
        language = [{
          name = "toml";
          formatter = {
            command = "taplo";
            args = [ "fmt" "-" ];
          };
          auto-format = true;
        }];
      };
      extraPackages = with pkgs; [
        taplo
      ];
    };
  };
}
