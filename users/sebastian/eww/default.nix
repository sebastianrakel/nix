{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    unstable.eww
  ];
  
  home.file."eww_config" = {
    source = ./config;
    target = ".config/eww";
  };
}
