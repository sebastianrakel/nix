{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  system.autoUpgrade = {
    enable = false;
    flake = "github:sebastianrakel/nix";
    dates = "*:0,15,30,45";
  };

  users.users.root = {
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo6u1C58Gc4ZzpgxsDSPK49i+bnvPZv/p5Tyw2/NwyP sebastian@sebastianrakel.de"
    ];
  };
  
  services.openssh.enable = true;

  users.mutableUsers = true;
  users.users.sebastian = {
    isNormalUser = true;
    initialPassword = "changeme";
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
    tmux
    wireguard-tools
    fzf
    silver-searcher
    jq
  ];

  programs = {
    zsh = {
      enable = true;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
