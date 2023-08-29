{ lib, pkgs }:
pkgs.buildGoModule rec {
  pname = "workspace-switcher";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "sebastianrakel";
    repo = "workspace-switcher";
    rev = "v${version}";
    hash = "sha256-NlKvgx7b0e2LQd9PzsvBOEFYQs7lMzw0TpYtRfdrmwY=";
  };

  vendorHash = "sha256-zZ/Psy/cYir4Vsccew2DqqBx2uznQk5bQ7dmWw5s2aI=";

  meta = {
    mainProgram = "workspace-switcher";
  };
}
