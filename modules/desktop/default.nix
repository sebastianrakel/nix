{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    rofi
    polybar
    feh
    emacs
    gnupg
  ];

  services.xserver = {
    enable = true;
    windowManager.herbstluftwm = {
      enable = true;
    };
    displayManager.startx.enable = true;
    libinput.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      mesa.drivers
    ];
  };
}
