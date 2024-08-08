{ config, pkgs, unstable, nur, lib, ... }:

with lib;
let
  cfg = config.gaming;
in {
  options = {
    gaming.enable = mkEnableOption "Enable gaming";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      openrct2 
    ];
  };
}

