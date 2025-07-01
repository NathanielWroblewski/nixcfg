{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.features.editor.helix.yaml;
in
{
  options.features.editor.helix.yaml.enable = mkEnableOption "Enable yaml lsp for helix";
  config = mkIf cfg.enable {

    programs.helix = {
      languages = {
        language = [{
          name = "yaml";
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.yaml" ];
          };
          auto-format = true;
        }];
      };
      extraPackages = with pkgs; [
        yaml-language-server
        nodePackages.prettier
      ];
    };
  };
}
