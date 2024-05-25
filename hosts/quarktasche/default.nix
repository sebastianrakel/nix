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

  networking.hostName = "quarktasche";
  networking.useDHCP = false;
  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  networking.firewall.enable = false;

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
  systemd.network.networks = {
    "10-lan" = {
      matchConfig.Name = "en*";
      dhcpV4Config.ClientIdentifier = "mac";
      networkConfig.DHCP = "yes";
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
