{ lib, inputs, config, pkgs, unstable, modulesPath, callPackage, ... }:
with lib;
let
  cfg = config.display-manager;
in {
  options.display-manager = {
    useWayland = mkOption {
      type = types.bool;
      default = false;
    };
  };

 
  imports = [
    ./displaymanager/wayland.nix
    ./displaymanager/xserver.nix
  ];
}

