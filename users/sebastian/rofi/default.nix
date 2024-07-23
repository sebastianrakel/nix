{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    rofi 
  ];
  
  home.file."rofi_power" = {
    source     = ./rofi_power.sh;
    target     = ".local/bin/rofi_power.sh";
    executable = true;
  };
}
