{ config, pkgs, unstable, nur, lib, ... }:

with lib;
let
  cfg = config.alacritty;
in {
  options = {
    alacritty.enable = mkEnableOption "Enable alacritty";
    alacritty.fontSize = mkOption {
      default = 16.0;
      type = types.float;
    };
  };

  config = mkIf cfg.enable {
    home.file."alacritty_theme" = {
      source = config.themes.base16.alacritty;
      target = ".config/alacritty/theme.toml";
    };
    
    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          "${config.home.homeDirectory}/.config/alacritty/theme.toml"
        ];
        font = {
          size = cfg.fontSize;
        };
      };
    };
    
    home.sessionVariables = {
      TERMINAL                    = "alacritty";
      WINIT_HIDPI_FACTOR          = 1;
      WINIT_X11_SCALE_FACTOR      = 1;
    };  
  };
}

