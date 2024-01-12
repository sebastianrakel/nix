{ lib, pkgs }:
pkgs.buildGoModule rec {
  pname = "workspace-switcher";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "sebastianrakel";
    repo = "workspace-switcher";
    rev = "v${version}";
    hash = "sha256-9yb1a8vsPA1+bCoFP0gioILuc09vTlizJbebJcaaD6Y=";
  };

  vendorHash = "sha256-zZ/Psy/cYir4Vsccew2DqqBx2uznQk5bQ7dmWw5s2aI=";

  meta = {
    mainProgram = "workspace-switcher";
  };
}
