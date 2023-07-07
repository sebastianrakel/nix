{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  services.pcscd.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.dconf.enable = true;

  nixpkgs.overlays = [
    (self: super: {
      jetbrains = super.jetbrains // {
        idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs (_: {
          version = "2023.1.3";
          src = super.fetchurl {
            url = "https://download-cdn.jetbrains.com/idea/ideaIU-2023.1.3.tar.gz";
            sha256 = "a58954ed6732eb799502e14b250ead8b21e00c3f064e196ada34dcd6a3a3f399";
          };
        });
      };
    })
  ];

  networking.firewall.enable = false;
  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    rofi
    polybar
    feh
    emacs
    gopass
    gopass-jsonapi
    pinentry-gnome
    mosh
    jetbrains.idea-ultimate
    go
    tdesktop
    direnv
    vscode
    pcmanfm
    chromium
    xscreensaver
    thunderbird
    pavucontrol
    jetbrains.datagrip
    jetbrains.pycharm-professional
    slack
    flameshot
    exfat
    remmina
    gajim
    arc-theme
    arc-icon-theme
    azure-cli
    spotify
    yubikey-manager
    discord
    postman
    git-crypt
    terraform
    nomad
    gcc
    inkscape
    kicad
    qflipper
    android-studio
    android-udev-rules
    android-tools
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  services.xserver = {
    enable = true;
    windowManager.herbstluftwm = {
      enable = true;
    };
    displayManager.startx.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      mesa.drivers
    ];
  };

  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  services.gvfs.enable = true;

  services.syncthing = {
    enable = true;
    user = "sebastian";
    dataDir = "/home/sebastian/Documents";
    configDir = "/home/sebastian/.config/syncthing";
  };

  location.latitude = 52.49857143211573;
  location.longitude = 7.227237925464914;
  services.redshift = {
    enable = true;
    temperature = {
      day = 5500;
      night = 3700;
    };
  };
}
