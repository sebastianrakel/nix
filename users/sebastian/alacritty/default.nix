{ config, pkgs, unstable, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${config.home.homeDirectory}/.base-16/themes/alacritty/base16-github.toml"
      ]; 
    };
  };
}
