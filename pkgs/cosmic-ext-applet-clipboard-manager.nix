{
  fetchFromGitHub,
  lib,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-applet-clipboard-manager";
  version = "unstable-2026-01-29";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "7cc5868882718a2994418f94b1330f20eae5c8e5";
    hash = "sha256-aciPTGN4yN4xmOB/9/MF+nhiF3JGYF7h4fsFHzL7Fws=";
  };

  cargoHash = "sha256-DmxrlYhxC1gh5ZoPwYqJcAPu70gzivFaZQ7hVMwz3aY=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];


  postPatch = ''
    substituteInPlace justfile \
      --replace-fail '`git rev-parse --short HEAD`' '"7cc5868"'
  '';

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-clipboard-manager"
  ];

  installTargets = [
    "install"
    "install-schema"
  ];

  preCheck = ''
    export XDG_RUNTIME_DIR="$TMP"
  '';


  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Clipboard manager for COSMIC";
    homepage = "https://github.com/cosmic-utils/clipboard-manager";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-applet-clipboard-manager";
  };
}
