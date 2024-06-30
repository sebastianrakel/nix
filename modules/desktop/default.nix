{ lib, inputs, config, pkgs, unstable, modulesPath, callPackage, ... }:
{

  imports = [
    ./browser.nix
    ./displaymanager.nix
  ];

  system.stateVersion = "23.11";

  services.dbus.enable = true;
  services.pcscd.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.dconf.enable = true;

  nixpkgs.overlays = [
    (final: prev: import ../../packages { pkgs = final; })
    (final: prev: { weechat = prev.weechat.override { configure = { availablePlugins, ... }: {
                      plugins = builtins.attrValues (availablePlugins // {
                        python = availablePlugins.python.withPackages (ps: with ps; [ requests ]);
                      });
                    }; };
                  })
  ];

  services.xserver = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    dbus
    alacritty
    rofi
    gopass
    gopass-jsonapi
    pinentry-gnome3
    mosh
    tdesktop
    direnv
    unstable.vscode
    chromium
    thunderbird
    pavucontrol
    slack
    flameshot
    exfat
    remmina
    gajim
    arc-theme
    arc-icon-theme
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
    unstable.yubioath-flutter
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
    (pkgs.yarn.override { nodejs = null; })
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
      pip
      requests
      pystache
      pyyaml
      python-lsp-server
    ]))
    libreoffice
    rustup
    platformio
    ccls
    unstable.go
    unstable.emacs29
    unstable.jetbrains.idea-ultimate
    unstable.jetbrains.datagrip
    unstable.jetbrains.rider
    lsd
    google-chrome
    bruno
    element-desktop
    libnotify
    typescript
    neofetch
    neovim
    lua-language-server
    lazygit
    postman
    mpd
    ncmpcpp
    signal-desktop
    emacs-lsp-booster
    senpai
    weechat
    multimarkdown
    playerctl
    omnisharp-roslyn
    zeal
    msmtp
    (pkgs.isync.override { withCyrusSaslXoauth2 = true; })
    notmuch
    aerc
    ffmpegthumbnailer
    (azure-cli.withExtensions [ azure-cli.extensions.azure-devops ])
    ruby
    bundler
    puppet-bolt
  ];

  programs.firefox.enable = true;
  programs.firefox.languagePacks = [
    "en-US"
    "de"
  ];
  programs.firefox.policies = {
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

  browser.starter = "firefox.desktop";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.fontconfig.defaultFonts.monospace = []; 

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      mesa.drivers
    ];
  };

  services.gvfs.enable = true;

  services.syncthing = {
    enable = true;
    user = "sebastian";
    dataDir = "/home/sebastian/Documents";
    configDir = "/home/sebastian/.config/syncthing";
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
}
