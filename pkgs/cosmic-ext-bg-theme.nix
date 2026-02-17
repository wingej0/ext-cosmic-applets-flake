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
  version = "unstable-2026-02-03";

  src = fetchFromGitHub {
    owner = "wash2";
    repo = "cosmic_ext_bg_theme";
    rev = "8856cab26546338a65fac7b8f7d579299fe4a479";
    hash = "sha256-3gfb2dmlT2aUrzSgNIjngOarsHVhBSE9Gw1ZzBnD+rg=";
  };

  cargoHash = "sha256-DNx3eISK5Wb3eKcJMjCJQwdjwAzmn12OJkM0uGsRNLw=";

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
