{ lib, inputs, config, pkgs, unstable, modulesPath, ... }:
lib.mkIf (! config.display-manager.useWayland) {
  environment.systemPackages = with pkgs; [
    feh
    xscreensaver
    xclip
    eww-wayland
  ];

  services.xserver.displayManager.sddm.enable = true;
  programs.hyprland.enable = true;
}
