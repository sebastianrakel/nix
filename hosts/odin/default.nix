{ lib, inputs, config, nixpkgs, modulesPath, hardwareModules, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "aesni_intel" "cryptd" "igb"];
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

  networking.hostName = "odin";
  services.xserver.videoDrivers = [ "modesetting" ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];

  system.stateVersion = "22.11";
}
