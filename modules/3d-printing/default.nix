{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    openscad
    super-slicer
    cura
    bambu-studio
  ];
}
