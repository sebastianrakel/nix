{ config, lib, pkgs, ... }:

with lib;

let
  xcfg = config.services.xserver;
  dmcfg = xcfg.displayManager;
  cfg = dmcfg.lemurs;
  xEnv = config.systemd.services.display-manager.environment;
  sessionData = dmcfg.sessionData;

  mk_save = cfg.defaultUser != null;
  tty = "tty${toString xcfg.tty}";
in {
  meta.maintainers = with maintainers; [ sebastianrakel ];

  options = {
    services.xserver.displayManager.lemurs = {
      enable = mkEnableOption "lemurs as the display manager.";

      package = mkOption {
        type = types.package;
        default = pkgs.lemurs;
        defaultText = literalExpression "pkgs.lemurs";
      };
    };
  };

  config = mkIf cfg.enable {

    assertions = [
      {
        assertion = xcfg.enable;
        message = ''
          lemurs requires services.xserver.enable to be true
        '';
      }
    ];

    environment.systemPackages = [ cfg.package ];
    environment.etc."lemurs/config.toml" = {
      mode = "0444";
      source = ./config.toml;
    };

    environment.etc."lemurs/wms/hlwm" = {
      mode = "0755";
      text = ''
        #! /bin/sh
        exec ${pkgs.herbstluftwm}/bin/herbstluftwm
      '';
    };

    services.xserver.displayManager.lightdm.enable = false;

    security.pam.services.lemurs.text = ''
        auth       substack     login
        account    include      login
        password   substack     login
        session    include      login
    '';

    services.xserver.displayManager.job.execCmd = ''
      exec ${cfg.package}/bin/lemurs
    '';

    systemd.services."autovt@${tty}".enable = false;

    systemd.services.lemurs = {
      unitConfig = {
        Wants= [
          "systemd-user-sessions.service"
        ];
        After = [
          "systemd-user-sessions.service"
          "plymouth-quit-wait.service"
          "getty@${tty}.service"
        ];
      };

      serviceConfig = {
        Type = "idle";
        ExecStart = "${cfg.package}/bin/lemurs";
        StandardInput = "tty";
        TTYPath = "/dev/${tty}";
        TTYReset = "yes";
        TTYVHangup = "yes";
      };

      restartIfChanged = false;

      wantedBy = [ "graphical.target" ];
    };

    systemd.defaultUnit = "graphical.target";

    users.users.lemurs = {
      isSystemUser = true;
      group = "lemurs";
    };

    users.groups.lemurs = {};
  };
}
