{ lib, ... }:
{
  hex_to_rgb = hex:
    let
      hex_value = lib.removePrefix "#" hex;
      r = builtins.substring 0 2 hex_value;
      g = builtins.substring 2 2 hex_value;
      b = builtins.substring 4 2 hex_value;
      hex_to_int = hex: builtins.fromJSON "0x${hex}";
    in
    {
      r = hex_to_int r;
      g = hex_to_int g;
      b = hex_to_int b;
    };
}
