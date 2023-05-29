{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    vagrant
    virt-manager
  ];

  users.users.sebastian = {
    extraGroups =
      [
        "qemu-libvirtd"
        "libvirtd"
      ];
  };
}
