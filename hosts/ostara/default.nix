{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.framework.12th-gen-intel
  ];
  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [
    "kvm-intel"
  ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-label/NIXCRYPT";
      preLVM = true;
    };
  };

  networking.hostName = "ostara";
  networking.useNetworkd = false;
  networking.networkmanager = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users.users.sebastian.extraGroups = [ "networkmanager" ];

  system.stateVersion = "22.11";
}
