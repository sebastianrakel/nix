{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  virtualisation.libvirtd.enable = true;

  users.users.sebastian = {
    extraGroups =
      [
        "qemu-libvirtd"
        "libvirtd"
      ];
  };
}
