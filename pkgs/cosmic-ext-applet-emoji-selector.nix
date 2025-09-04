{
 lib,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  stdenv,
  util-linux,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-applet-emoji-selector";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "bGVia3VjaGVu";
    repo = "cosmic-ext-applet-emoji-selector";
    rev = "v${version}";
    hash = "sha256-tUfrurThxN++cZiCyVHr65qRne9ZXzWtMuPb0lqOijE=";
  };

  cargoHash = "sha256-vI8pIOo8A9Ebyati4c0CyGxuf4YQKEaSdG28CQ1/w3w=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
    util-linux
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
  ];

  installTargets = [
    "install"
    "install-schema"
  ];

  postPatch = ''
    substituteInPlace justfile \
      --replace-fail './target/release' './target/${stdenv.hostPlatform.rust.cargoShortTarget}/release' \
      --replace-fail '~/.config/cosmic' "$out/share/cosmic"
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Emoji Selector for COSMIC™\u{fe0f} DE";
    homepage = "https://github.com/bGVia3VjaGVu/cosmic-ext-applet-emoji-selector";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-applet-emoji-selector";
  };
}
