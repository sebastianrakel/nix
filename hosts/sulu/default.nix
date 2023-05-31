{ lib, inputs, config, pkgs, modulesPath, hardwareModules, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "aesni_intel" "cryptd" "r8169"];
  boot.kernelModules = [
    "kvm-amd"
  ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-label/NIXCRYPT";
      preLVM = true;
    };
  };

  networking.hostName = "sulu";
  services.xserver.videoDrivers = [ "modesetting" ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    cups-kyodialog3 = pkgs.cups-kyodialog3.override { region = "EU"; };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];

  systemd.network.enable = true;
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.ClientIdentifier = "mac";
  };

  systemd.network.links."10-wol" = {
    matchConfig = {
      MACAddress = "3c:7c:3f:d7:c9:cc";
    };
    linkConfig = {
      NamePolicy = "kernel database onboard slot path";
      MACAddressPolicy = "persistent";
      WakeOnLan = "magic";
    };
  };

  system.stateVersion = "22.11";
}
