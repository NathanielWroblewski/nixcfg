{ pkgs, inputs, ... }:
{
  stylix.fonts = {
    serif = {
      package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
      name = "SFProDisplay Nerd Font";
    };
  };
}
