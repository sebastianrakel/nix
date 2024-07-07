{ config, pkgs, ... }:
{
  home.username = "sebastian";

  programs.git = {
    enable = true;
    userName = "Sebastian Rakel";
    userEmail = "sebastian@devunit.eu";
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
