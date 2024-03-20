{ lib, config, ... }:
with lib;
let
  cfg = config.browser;
in {
  options.browser = {
    starter = mkOption {
      type = types.str;
      default = "firefox.desktop";
    };
  };

  config.xdg.mime.defaultApplications = {
    "text/html" = cfg.starter;
    "x-scheme-handler/http" = cfg.starter;
    "x-scheme-handler/https" = cfg.starter;
  };
}
