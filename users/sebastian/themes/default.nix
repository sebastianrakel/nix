{ lib, inputs, theming, ... }:
let
  inherit (theming.lib.base16) getAllThemePaths;
in
{
  options.themes = {
    base16 = lib.mkOption {
      type = lib.types.raw;
      apply = name: { __toString = _: name; } // getAllThemePaths name;
    };
  };
}
