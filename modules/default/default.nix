{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  system.autoUpgrade = {
    enable = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo6u1C58Gc4ZzpgxsDSPK49i+bnvPZv/p5Tyw2/NwyP sebastian@sebastianrakel.de"
  ];
  services.openssh.enable = true;

  users.users.sebastian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo6u1C58Gc4ZzpgxsDSPK49i+bnvPZv/p5Tyw2/NwyP sebastian@sebastianrakel.de"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    emacs
    htop
    mtr
    restic
    unzip
  ];

  programs = {
    zsh = {
      enable = true;
    };
  };
}
