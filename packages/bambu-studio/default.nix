{ pkgs, lib, ... }:
let
  pname = "bambu-studio";
  version = "v01.08.04.51";

  name = pname;
  
  src = pkgs.fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/${version}/BambuStudio_linux_ubuntu_${version}_20240117.AppImage";
    sha256 = "sha256-aeRKOXzIwKlYMkmpWCmGmna22G/gVhDIiacZRXbgpM4=";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name version src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit name version src;

  extraPkgs = pkgs: with pkgs; [
    webkitgtk
    curl
    cacert
    glib-networking
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-good
  ];

  profile = ''
    export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
  '';
  
  meta = with lib; {
    description = "PC Software for BambuLab's 3D printers";
    homepage = "https://github.com/bambulab/BambuStudio";
    license = licenses.agpl3;
    maintainers = with maintainers; [ sebastianrakel ];
    mainProgram = "bambu-studio";
    platforms = platforms.linux;
  };

}
