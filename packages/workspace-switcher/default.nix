{ pkgs }:
pkgs.buildGoModule {
  pname = "workspace-switcher";
  version = "0.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "sebastianrakel";
    repo = "workspace-switcher";
    rev = "main";
    hash = "sha256-qWRXqpHstkeCURckPJQMV4SSXHkzOUgmYnEQioFiCiE=";
  };

  vendorHash = "sha256-zZ/Psy/cYir4Vsccew2DqqBx2uznQk5bQ7dmWw5s2aI=";

  meta = {
    mainProgram = "workspace-switcher";
  };
}
