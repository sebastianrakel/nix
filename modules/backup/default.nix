{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  services.restic.backups.${config.networking.hostName} = {
    user = "sebastian";
    paths = [
      "/home/sebastian"
    ];
    initialize = true;
    passwordFile = "/home/sebastian/.restic-password";
    exclude = [
      "/home/*/.cache"
      "/home/*/.local/cache"
      "/home/*/.vagrant.d"
    ];
  };
}
