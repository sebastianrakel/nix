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
          version = "2023.2";
          src = super.fetchurl {
            url = "https://download-cdn.jetbrains.com/idea/ideaIU-2023.2.tar.gz";
            sha256 = "d398599557cc732fd1f58f38104d7cda35e326e4cd394245a8358e02fb8878b3";
          };
        });
        pycharm-professional = super.jetbrains.pycharm-professional.overrideAttrs (_: {
          version = "2023.2";
          src = super.fetchurl {
            url = "https://download-cdn.jetbrains.com/python/pycharm-professional-2023.2.tar.gz";
            sha256 = "95f1666c471a9d752c53ec0b776840552e023f6405a3b000ce6f1014125bfc83";
          };
        });
        rider = super.jetbrains.rider.overrideAttrs (_: {
          version = "2023.2";
          src = super.fetchurl {
            url = "https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2023.2.tar.gz";
            sha256 = "1aa3436edb94cba8ec0e51605e146ecd528affa96e0e26df572c2437e9b00d2f";
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
    emacs29
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
    gimp
    imagemagick
    yubioath-flutter
    nextcloud-client
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

  services.fwupd.enable = true;

  programs.evolution = {
    enable = true;
    plugins = [ pkgs.evolution-ews ];
  };
}
