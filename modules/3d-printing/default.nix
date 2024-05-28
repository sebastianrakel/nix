{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    openscad
    cura
    bambu-studio
    freecad
  ];
}
