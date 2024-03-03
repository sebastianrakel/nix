{ lib, stdenv, fetchurl, cmake, pkg-config, python3, libX11, libXext, libXinerama, libXrandr, libXft, libXrender, libXdmcp, libXfixes, libxslt, freetype, asciidoc
, xdotool, xorgserver, xsetroot, xterm, runtimeShell
, fetchpatch, fetchFromGitHub
, nixosTests }:

stdenv.mkDerivation rec {
  pname = "herbstluftwm-git";
  version = "0.9.6-rc1";
  
  src = fetchFromGitHub {
    owner = "herbstluftwm";
    repo = "herbstluftwm";
    rev = "master";
    hash = "sha256-Otp8ifYqHSYDVYw09hYvGqZ8DYY1/LDWfGBONOt6vuQ=";
  };

  outputs = [
    "out"
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_SYSCONF_PREFIX=${placeholder "out"}/etc"
    "-DWITH_DOCUMENTATION=false"
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    libxslt
  ];

  depsBuildBuild = [
    libxslt
    asciidoc
  ];

  buildInputs = [
    libxslt
    libX11
    libXext
    libXinerama
    libXrandr
    libXft
    libXrender
    libXdmcp
    libXfixes
    freetype
  ];

  patches = [
    ./test-path-environment.patch
  ];

  postPatch = ''
    patchShebangs doc/gendoc.py
    patchShebangs doc/format-doc.py
    patchShebangs doc/patch-manpage-xml.py

    # fix /etc/xdg/herbstluftwm paths in documentation and scripts
    grep -rlZ /etc/xdg/herbstluftwm share/ doc/ scripts/ | while IFS="" read -r -d "" path; do
      substituteInPlace "$path" --replace /etc/xdg/herbstluftwm $out/etc/xdg/herbstluftwm
    done

    # fix shebang in generated scripts
    substituteInPlace tests/conftest.py --replace "/usr/bin/env bash" ${runtimeShell}
    substituteInPlace tests/test_herbstluftwm.py --replace "/usr/bin/env bash" ${runtimeShell}
  '';

  doCheck = false;

  nativeCheckInputs = [
    (python3.withPackages (ps: with ps; [ ewmh pytest xlib ]))
    xdotool
    xorgserver
    xsetroot
    xterm
    python3.pkgs.pytestCheckHook
  ];

  # make the package's module available
  preCheck = ''
    export PYTHONPATH="$PYTHONPATH:../python"
  '';

  pytestFlagsArray = [ "../tests" ];
  disabledTests = [
    "test_autostart" # $PATH problems
    "test_wmexec_to_other" # timeouts in sandbox
    "test_rules" # timeouts
  ];

  passthru = {
    tests.herbstluftwm = nixosTests.herbstluftwm;
  };

  meta = with lib; {
    description = "A manual tiling window manager for X";
    homepage = "https://herbstluftwm.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
  };
}
