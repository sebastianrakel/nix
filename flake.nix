{
  description = "My Nixos Flake Stuff";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/release-23.05;
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, utils, nixos-hardware }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      hostDefaults = {
        system = "x86_64-linux";
        modules = [
          ./modules/default
        ];
      };

      hosts.ostara.modules = [
        ./hosts/ostara
        ./modules/systemd-boot
        ./modules/desktop
      ];
    };
}
