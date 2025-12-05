{
  fetchFromGitHub,
  git,
  lib,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
  wl-clipboard,
  makeWrapper,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-applet-clipboard-manager";
  version = "unstable-2025-11-27";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "4e509f5dd9513db58a699748314f388ed4664348";
    hash = "sha256-a96jEzbKlgScnFzbqs6ckpm8m19l4/mZt074GeOsUHI=";
  };

  cargoHash = "sha256-DmxrlYhxC1gh5ZoPwYqJcAPu70gzivFaZQ7hVMwz3aY=";

  nativeBuildInputs = [
    git
    libcosmicAppHook
    just
    makeWrapper
  ];

  buildInputs = [
    wl-clipboard
  ];

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

  preCheck = ''
    export XDG_RUNTIME_DIR="$TMP"
  '';

  postPatch = ''
    substituteInPlace justfile \
      --replace-fail 'export CLIPBOARD_MANAGER_COMMIT := `git rev-parse --short HEAD`' \
                     'export CLIPBOARD_MANAGER_COMMIT := "${src.rev}"'
  '';

  postInstall = ''
    wrapProgram $out/bin/cosmic-ext-applet-clipboard-manager \
      --prefix PATH : ${lib.makeBinPath [ wl-clipboard ]}
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
