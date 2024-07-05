{ lib, buildGoModule, fetchFromSourcehut, installShellFiles, scdoc }:

buildGoModule rec {
  pname = "senpai";
  version = "0.3.0";

  src = fetchFromSourcehut {
    owner = "~delthas";
    repo = "senpai";
    rev = "a2cdd743aaadb2d06d92cf1a89966cc12caebb0d";
    sha256 = "sha256-tPx+3wwV8iaxssSJR+WjVmIug8CI4LrTDQq1ez8Q3gw=";
  };

  vendorHash = "sha256-M0RTWnObED/5XseZt0gQxGdqYfl1CNemGqSPbRNIHZI=";

  subPackages = [
    "cmd/senpai"
  ];

  nativeBuildInputs = [
    scdoc
    installShellFiles
  ];

  postInstall = ''
    scdoc < doc/senpai.1.scd > doc/senpai.1
    scdoc < doc/senpai.5.scd > doc/senpai.5
    installManPage doc/senpai.*
  '';

  meta = with lib; {
    description = "Your everyday IRC student";
    mainProgram = "senpai";
    homepage = "https://sr.ht/~taiite/senpai/";
    changelog = "https://git.sr.ht/~delthas/senpai/refs/v${version}";
    license = licenses.isc;
    maintainers = with maintainers; [ malte-v ];
  };
}
