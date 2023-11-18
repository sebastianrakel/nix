{
  description = "My Nixos Flake Stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, fup, nixos-hardware, disko, sops-nix }:
    fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      hostDefaults = {
        system = "x86_64-linux";
        channelName = "nixpkgs";
        modules = [
          disko.nixosModules.disko
          ./modules/default
          sops-nix.nixosModules.sops
        ];
        specialArgs = {
          hardwareModules = nixos-hardware.nixosModules;
          disko = disko.nixosModules;
          unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
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
        ./modules/systemd-boot
        ./modules/desktop
        ./modules/vagrant
        ./modules/backup
        ./modules/luks-ssh
        ./modules/podman
        ./modules/3d-printing
        ./modules/printing
      ];
    };
}
