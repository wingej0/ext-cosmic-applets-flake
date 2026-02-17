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
  version = "unstable-2026-01-17";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-weather";
    rev = "142666f73c702036438408758ea86ec22d63611b";
    hash = "sha256-K4flguR6pknhFCpwHQ+4OtSAtPBjUag1g/uUnCNM3Pw=";
  };

  cargoHash = "sha256-LcTUIhAWitLFz23TasfSJt6tOAAAJDiHxfTcxBX2/Bg=";

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