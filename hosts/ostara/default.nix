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

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];
  networking.hostName = "ostara";

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.libinput.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  users.users.sebastian.extraGroups = [ "networkmanager" ];
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  system.stateVersion = "22.11";
}
