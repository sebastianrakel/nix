{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  boot.initrd.network.enable = true;
  boot.initrd.network.ssh = {
    enable = true;
    port = 22;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo6u1C58Gc4ZzpgxsDSPK49i+bnvPZv/p5Tyw2/NwyP sebastian@sebastianrakel.de"
    ];
    hostKeys = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
}
