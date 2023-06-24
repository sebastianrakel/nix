{
  description = "My Nixos Flake Stuff";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/release-23.05;
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, fup, nixos-hardware }:
    fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      hostDefaults = {
        system = "x86_64-linux";
        channelName = "nixpkgs";
        modules = [
          ./modules/default
        ];
        specialArgs = {
          hardwareModules = nixos-hardware.nixosModules;
        };
      };

      hosts.ostara.modules = [
        ./hosts/ostara
        ./modules/networkmanager
        ./modules/systemd-boot
        ./modules/desktop
        ./modules/vagrant
        ./modules/3d-printing
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
