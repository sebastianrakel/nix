{
  description = "My Nixos Flake Stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, fup, nixos-hardware, disko }:
    fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      hostDefaults = {
        system = "x86_64-linux";
        channelName = "nixpkgs";
        modules = [
          disko.nixosModules.disko
          ./modules/default
        ];
        specialArgs = {
          hardwareModules = nixos-hardware.nixosModules;
          disko = disko.nixosModules;
        };
      };

      hosts.ostara.modules = [
        ./hosts/ostara
        ./modules/systemd-boot
        ./modules/desktop
        ./modules/vagrant
        ./modules/3d-printing
        ./modules/bluetooth
        ./modules/gaming
        ./modules/printing
        ./modules/podman
      ];

      hosts.sulu.modules = [
        ./hosts/sulu
        ./modules/systemd-boot
        ./modules/desktop
        ./modules/vagrant
        ./modules/backup
        ./modules/luks-ssh
        ./modules/podman
        ./modules/printing
        ./modules/bluetooth
      ];

      hosts.odin.modules = [
        ./hosts/odin
        ./modules/networkmanager
        ./modules/systemd-boot
        ./modules/desktop
        ./modules/vagrant
        ./modules/backup
        ./modules/luks-ssh
        ./modules/podman
        ./modules/3d-printing
      ];
    };
}
