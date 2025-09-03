{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  stdenv,
  darwin,
  wayland,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-bg-theme";
  version = "unstable-2025-07-24";

  src = fetchFromGitHub {
    owner = "wash2";
    repo = "cosmic_ext_bg_theme";
    rev = "3c338ef06e0e332a874e52ac0cc10c2a8d29a4f6";
    hash = "sha256-iqOA0n0LOpzVugyijKkyQVLoRyF9J8QpbeWCSaH4kIk=";
  };

  cargoHash = "sha256-6R9JY55fEKGrByCJzR3Ifan03MsVYusMonMPZzCXqHc=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      libxkbcommon
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.CoreServices
    ]
    ++ lib.optionals stdenv.isLinux [
      wayland
    ];

  meta = {
    description = "";
    homepage = "https://github.com/wash2/cosmic_ext_bg_theme";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-bg-theme";
  };
}
