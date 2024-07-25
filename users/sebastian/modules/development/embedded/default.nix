{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    unstable.pico-sdk
    unstable.picotool
    unstable.platformio-core
    unstable.cmake
    unstable.gcc-arm-embedded
  ];

  home.sessionVariables = {
    PICO_SDK_PATH = "${unstable.pico-sdk}/lib/pico-sdk/"; 
  };
}
