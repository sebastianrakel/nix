{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, gtk3
, librsvg
, withWayland ? false
, gtk-layer-shell
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "unstable-2024-01-03";

  src = fetchFromGitHub {
    owner = "elkowar";
    repo = "eww";
    rev = "65d622c81f2e753f462d23121fa1939b0a84a3e0";
    hash = "sha256-MR91Ytt9Jf63dshn7LX64LWAVygbZgQYkcTIKhfVNXI=";
  };

  cargoHash = "sha256-W8UH7y9sqXAYp2fgZJoZyihFgceCX6nClI512LU5XT8=";

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];

  buildInputs = [ gtk3 librsvg ] ++ lib.optional withWayland gtk-layer-shell;

  buildNoDefaultFeatures = true;
  buildFeatures = [
    (if withWayland then "wayland" else "x11")
  ];

  cargoBuildFlags = [ "--bin" "eww" ];

  cargoTestFlags = cargoBuildFlags;

  # requires unstable rust features
  RUSTC_BOOTSTRAP = 1;

  meta = with lib; {
    description = "ElKowars wacky widgets";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda lom ];
    mainProgram = "eww";
    broken = stdenv.isDarwin;
  };
}
