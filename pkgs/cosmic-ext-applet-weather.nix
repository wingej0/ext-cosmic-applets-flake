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
  version = "unstable-2025-12-03";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-weather";
    rev = "289d866abaaeaf51e9b7074b7731bcd6e5ea4b55";
    hash = "sha256-LeUzDjUiDt3lQiQQvDB9RlSC1F4IyXTE4lc17eQd+Sw=";
  };

  cargoHash = "sha256-1lIWzCqpIxk+FWA/84yN/x10Se2xRTZ7KEqAWVgfFgU=";

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