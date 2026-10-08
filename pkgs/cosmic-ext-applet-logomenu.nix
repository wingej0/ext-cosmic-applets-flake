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
  pname = "cosmic-ext-applet-logomenu";
  version = "unstable-2026-09-03";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-logomenu";
    rev = "41ab1aa280102c5c380b9457aa0ef8b20b6bdd51";
    hash = "sha256-P/HaibYdzI6HgNyi1OBabP1WiZcJpUjQeIlcDgVd93Y=";
  };

  cargoHash = "sha256-SDBRHhneZ2y99Qzwc+QF87dOgjUFhA29kbxNIQsYh8k=";

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
    "bin-src1"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-logomenu"
    "--set"
    "bin-src2"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-logomenu-settings"
  ];

  # The applet launches the settings app by name, so make sure it can find it
  preFixup = ''
    libcosmicAppWrapperArgs+=(--prefix PATH : "$out/bin")
  '';

  # Upstream tests add a second full dependency build for little coverage
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A customisable menu applet for the COSMIC desktop";
    homepage = "https://github.com/cosmic-utils/cosmic-ext-applet-logomenu";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-ext-applet-logomenu";
  };
}
