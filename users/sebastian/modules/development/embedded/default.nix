{ config, pkgs, unstable, ... }:
let
  pico_sdk = (unstable.pico-sdk.override { withSubmodules = true; });
in { 
  home.packages = with pkgs; [
    pico_sdk
    unstable.picotool
    unstable.platformio-core
    unstable.cmake
    unstable.gcc-arm-embedded
    unstable.glibc_multi
    unstable.rshell
    unstable.tio
    unstable.minicom
  ];

  home.sessionVariables = {
    PICO_SDK_PATH = "${pico_sdk}/lib/pico-sdk/"; 
  };
}
