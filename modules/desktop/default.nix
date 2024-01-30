{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
{
  system.stateVersion = "23.11";
  
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

  environment.systemPackages = with pkgs; [
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
    dotnet-sdk_8
    (python311.withPackages (p: with p; [
      requests
      pystache
      pyyaml
    ]))
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
    bruno
    eww
    element-desktop
    libnotify
    typescript
    xclip
    neofetch
    neovim
    lua-language-server
    lazygit
	  postman
    mpd
    ncmpcpp
  ];

  programs.firefox.enable = true;
  programs.firefox.languagePacks = [
    "en-US"
    "de"
  ];
  programs.firefoxn.policies = {
    DisableFeedbackCommands = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxScreenshots = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableSetDesktopBackground = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    HardwareAcceleration = true;
    OverrideFirstRunPage = "about:blank";
    OverridePostUpdatePage = "about:blank";
    PasswordManagerEnabled = false;
    
    FirefoxHome = {
      SponsoredTopSites = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
    };

    FirefoxSuggest.SponsoredSuggestions = false;

    ExtensionSettings =
    let
      mkAddOn = name: id: {
        "${id}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    in lib.mkMerge [
      (mkAddOn "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
      (mkAddOn "ublock-origin" "uBlock0@raymondhill.net")
      (mkAddOn "gopass-bridge" "{eec37db0-22ad-4bf1-9068-5ae08df8c7e9}")
      
    ];
  };

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
