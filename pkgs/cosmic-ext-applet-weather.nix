{
  lib,
  fetchFromGitHub,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-applet-weather";
  version = "unstable-2026-10-07";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-weather";
    rev = "9c295eec5850e39f5c652db7a1e412eb723750c3";
    hash = "sha256-27EAI2G6ekl8jG/iQShSqm97d2EbobWEB6A/jp83DAs=";
  };

  cargoHash = "sha256-QbEnqAY9fiIkdTCurXTegnXCt+n9O+3Rix8XjHKRxTQ=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-weather"
  ];

  # Upstream tests add a second full dependency build for little coverage
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Simple weather info applet for cosmic";
    homepage = "https://github.com/cosmic-utils/cosmic-ext-applet-weather";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-applet-weather";
  };
}