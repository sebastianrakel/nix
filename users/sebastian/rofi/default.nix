{ config, pkgs, unstable, ... }:
{
  programs.rofi = {
    enable = true;
    theme  = config.themes.base16.rofi;
  }; 
  
  home.file."rofi_power" = {
    source     = ./rofi_power.sh;
    target     = ".local/bin/rofi_power.sh";
    executable = true;
  };
}
