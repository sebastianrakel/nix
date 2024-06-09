{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    openscad
    cura
    unstable.bambu-studio
    freecad
  ];
}
