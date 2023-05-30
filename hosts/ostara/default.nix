{ lib, inputs, config, nixpkgs, modulesPath, hardwareModules, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    hardwareModules.framework-12th-gen-intel
  ];
  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "aesni_intel" "cryptd" ];
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
  services.xserver.libinput.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users.users.sebastian.extraGroups = [ "networkmanager" ];

  system.stateVersion = "22.11";
}
