{ config, pkgs, unstable, ... }:
{
  home.username = "sebastian";
  xsession.enable = true;
 
  home.packages = with pkgs; [
    fzf
    rink
    monaspace
  ];

  home.sessionVariables = {
      BROWSER                     = "firefox";
      VAGRANT_DEFAULT_PROVIDER    = "libvirt";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
  };

  imports = [
    ./alacritty
    ./rofi
    ./herbstluftwm
    ./emacs
    ./zsh
    ./git
    ./eww
    ./modules/development/go
  ];
  
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
