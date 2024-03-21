{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
lib.mkIf (config.display-manager.useWayland) {
  environment.systemPackages = with pkgs; [
    eww-wayland
    swaylock
    hyprpaper
  ];

  security.pam.services.swaylock = {};
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.hyprland.enable = true;
}
