{ config, pkgs, unstable, ... }:
{
  home.file."eww_config" = {
    source = ./config;
    target = ".config/eww";
  };
}
