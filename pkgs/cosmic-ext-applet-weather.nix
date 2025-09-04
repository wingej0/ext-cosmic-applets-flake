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
  version = "unstable-2025-08-23";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-weather";
    rev = "f613c9dd156e84290765c34ca98ff8ede3b530fa";
    hash = "sha256-VHCgMw4nWTKAbanEnMS/xCUzEW3NeWGmVkBqU2bJP/c=";
  };

  cargoHash = "sha256-CS4P1DHzTmkZdANw6UQsB0kjKTeaf3cAQ/2EiPHSg7g=";

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
