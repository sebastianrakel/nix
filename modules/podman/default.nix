{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
    podman-desktop
  ];
}
