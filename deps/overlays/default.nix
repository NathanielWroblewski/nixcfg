{ inputs, ... }:
{
  # overlays are overrides for packages

  # This one brings our custom packages from the '../imports' directory
  additions = final: _prev: import ../imports { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {
      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });
    };
}
