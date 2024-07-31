{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    unstable.delve
    unstable.gdlv
    unstable.gopls
    unstable.go
    unstable.air
  ];

  home.sessionVariables = {
    GOPATH                      = "${config.home.homeDirectory}/.go";
  };
}
