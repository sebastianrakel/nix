{ config, lib, pkgs, ... }:

with lib;

let
  cfg = dmcfg.lemurs;
  dmcfg = config.services.xserver.displayManager;
  xcfg = config.services.xserver;
  mk_save = cfg.defaultUser != null;

  lemursPkg = pkgs.lemurs;
in

{
  options = {
    services.xserver.displayManager.lemurs = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Lemurs as the display manager.
        '';
      };

      package = mkOption {
        default = lemursPkg;
        description = "lemurs package to use.";
      };
    };

  };


  ###### implementation

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.job.execCmd = "exec ${lemursPkg}/bin/lemurs";
      displayManager.lightdm.enable = lib.mkForce false;
    };

    systemd.services.display-manager.after = [
      "rc-local.service"
      "systemd-machined.service"
      "systemd-user-sessions.service"
      "getty@tty2.service"
      "user.slice"
    ];

    systemd.services.display-manager.serviceConfig = {
      Type = "idle";
      After = ["systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString xcfg.tty}.service"];
      StandardInput = "tty";
      ExecStart = "${lemursPkg}/bin/lemurs";
      TTYPath = "/dev/tty${toString xcfg.tty}";
      TTYReset = true;
      TTYVHangup = true;
    };
  };
}
