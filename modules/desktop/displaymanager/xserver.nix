{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
lib.mkIf (! config.display-manager.useWayland) {
  environment.systemPackages = with pkgs; [
    feh
    xscreensaver
    xclip
    eww
  ];

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.gnupg.agent = {
    pinentryFlavor = "gnome3";
  };

  systemd.user.services.xscreensaver-suspend = {
    restartIfChanged = false;
    unitConfig = {
      Description = "Helper service to bind locker to sleep.target";
    };
    serviceConfig = {
      ExecStart = "${pkgs.xscreensaver}/bin/xscreensaver-command -lock";
      Typescript = "simple";
    };
    before = [
      "pre-sleep.service"
    ];
    wantedBy= [
      "pre-sleep.service"
    ];
    environment = {
      DISPLAY = ":0";
        XAUTHORITY = "/home/sebastian/.Xauthority";
    };
  };

  services.xserver = {
    windowManager.herbstluftwm = {
      enable = true;
      package = pkgs.herbstluftwm-git;
    };
    displayManager.startx.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
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
