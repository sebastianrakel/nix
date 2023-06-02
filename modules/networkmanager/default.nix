{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  networking.networkmanager.enable = true;
  users.users.sebastian.extraGroups = [ "networkmanager" ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
