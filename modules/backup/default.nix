{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  services.restic.backups.${config.networking.hostName} = {
    user = "sebastian";
    paths = [
      "/home/sebastian"
    ];
    initialize = true;
    passwordFile = "/home/sebastian/.restic-password";
    repositoryFile = "/home/sebastian/.restic-repo";
    exclude = [
      "/home/*/.cache"
      "/home/*/.local/cache"
      "/home/*/.local/share/containers"
      "/home/*/.vagrant.d"
    ];
    timerConfig = {
      OnCalendar = "*:0,15,30,45";
      RandomizedDelaySec = "30s";
    };
  };
}
