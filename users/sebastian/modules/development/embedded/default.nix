{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    unstable.pico-sdk
    unstable.picotool
  ];
}
