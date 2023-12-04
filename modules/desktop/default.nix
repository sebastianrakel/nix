{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
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
    (final: prev: import ../../packages { pkgs = final; })
  ];

  networking.firewall.enable = false;
  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    rofi
    polybar
    feh
    gopass
    gopass-jsonapi
    pinentry-gnome
    mosh
    tdesktop
    direnv
    vscode
    chromium
    xscreensaver
    thunderbird
    pavucontrol
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
    unstable.postman
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
    texstudio
    texlive.combined.scheme-full
    android-tools
    gh
    kdiff3
    workspace-switcher
    fb-client
    dunst
    mpv
    nodejs_18
    yarn
    gnumake
    aspell
    aspellDicts.en
    aspellDicts.de
    ispell
    terraform-ls
    cinnamon.nemo
    ripgrep
    lsd
    dotnet-sdk
    python3
    libreoffice
    rustup
    platformio
    ccls
    unstable.go
    unstable.emacs29
    unstable.jetbrains.idea-ultimate
    unstable.jetbrains.datagrip
    unstable.jetbrains.pycharm-professional
    unstable.jetbrains.rider
    lsd
    google-chrome
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
      package = pkgs.herbstluftwm-git;
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

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  programs.adb.enable = true;
  users.users.sebastian.extraGroups = [
    "adbusers"
    "dialout"
  ];
    
  programs.evolution = {
    enable = true;
    plugins = [ pkgs.evolution-ews ];
  };
}
