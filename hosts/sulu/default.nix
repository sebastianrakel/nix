{ lib, inputs, config, pkgs, modulesPath, hardwareModules, disko, ... }:
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

  swapDevices = [ { device = "/dev/disk/by-label/NIXSWAP"; } ];

  networking.hostName = "sulu";
  networking.useDHCP = true;
  networking.useNetworkd = true;
  networking.firewall.enable = false;
  services.xserver.videoDrivers = [ "modesetting" ];

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

  services.teamviewer.enable = true;

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

  services.twingate.enable = true;

  system.stateVersion = "23.11";
}
