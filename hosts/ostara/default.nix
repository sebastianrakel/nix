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

  boot.extraModprobeConfig = ''
    options iwlwifi disable_11ax=Y
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  nixpkgs.overlays = [ (final: prev: {vaapiIntel = prev.vaapiIntel.override { enableHybridCodec = true; }; }) ];

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];
  networking.hostName = "ostara";
  networking.useDHCP = false;

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.libinput.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  services.xserver.libinput.touchpad.disableWhileTyping = true;
  services.hardware.bolt.enable = true;

  systemd.network.enable = true;
  systemd.network.networks = {
    "10-lan" = {
      matchConfig.Name = "en*";
      networkConfig.DHCP = "yes";
      dhcpV4Config.ClientIdentifier = "mac";
    };
    "10-wlan" = {
      matchConfig.Name = "wl*";
      networkConfig.DHCP = "yes";
      dhcpV4Config.ClientIdentifier = "mac";
    };
  };

  networking.wireless.iwd.enable = true;
  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
