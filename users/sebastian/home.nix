{ lib, utils, osConfig, config, pkgs, unstable, nur, ... }:
{
  imports = [
    ./zsh
    ./rofi
    ./herbstluftwm
    ./emacs
    ./git
    ./eww
    ./modules/development/go
    ./modules/development/embedded
    ./modules/alacritty
    ./themes
  ] ++ lib.optional (builtins.pathExists ./configurations/${osConfig.networking.hostName}) ./configurations/${osConfig.networking.hostName};
  
  home.username = "sebastian";
  xsession.enable = true;

  home.packages = with pkgs; [
    fzf
    rink
    monaspace
    nur.fb-client
    nur.workspace-switcher
  ];

  home.sessionVariables = {
      BROWSER                     = "firefox";
      VAGRANT_DEFAULT_PROVIDER    = "libvirt";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
  };

  themes.base16 = "github";
  
  alacritty.enable = true;
  herbstluftwm.enable = true;
  herbstluftwm.wallpaper = "nasa_cloud.jpg";
  
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
