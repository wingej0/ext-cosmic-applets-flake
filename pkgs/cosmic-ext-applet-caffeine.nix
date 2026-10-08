{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-applet-caffeine";
  version = "unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "tropicbliss";
    repo = "cosmic-ext-applet-caffeine";
    rev = "e427a1a903fd612a09477d0e90bd4aed4a494a08";
    hash = "sha256-nsO6UMW9T2wHtpcuZNm6VB7PMsqdiNUxKrU2K9/VYV4=";
  };

  cargoHash = "sha256-9EUrO8JNU0FPrqT6WDE+jfVgQSgODK8rbNZLgUb26EQ=";

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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-caffeine"
  ];

  # Upstream tests add a second full dependency build for little coverage
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Caffeine Applet for the COSMIC™ desktop";
    homepage = "https://github.com/tropicbliss/cosmic-ext-applet-caffeine/tree/main";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-applet-caffeine";
  };
}
