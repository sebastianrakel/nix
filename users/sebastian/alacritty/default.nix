{ config, pkgs, unstable, ... }:
{
  home.file."alacritty_theme" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/aarowill/base16-alacritty/master/colors/base16-harmonic16-light.toml";
      sha256 = "1w3ldl0scy7rmq8qp3bc223ygh4z3nnd668g9q84sl7nraj611fy";
    };
    target = ".config/alacritty/theme.toml";
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${config.home.homeDirectory}/.config/alacritty/theme.toml"
      ]; 
    };
  };

  home.sessionVariables = {
    TERMINAL                    = "alacritty";
    WINIT_HIDPI_FACTOR          = 1;
    WINIT_X11_SCALE_FACTOR      = 1;
  };
}
