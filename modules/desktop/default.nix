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
}
