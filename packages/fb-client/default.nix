{ lib, pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "fb-client";
  version = "2.3.0";

  src = pkgs.fetchurl {
    url = "https://paste.xinu.at/data/client/fb-${version}.tar.gz";
    sha256 = "sha256-EWTsoG7qy0IQ1GLEuvHEAEJyphl9hz1hFm53k1OdGYM=";
  };

  buildInputs =
    [ (pkgs.python3.withPackages (pyPkgs: with pyPkgs; [ pycurl pyxdg ])) ];

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    mainProgram = "fb";
    description = "Client for paste.xinu.at";
    homepage = "https://paste.xinu.at";
    license = licenses.gpl3Only;
  };
}
