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
  version = "unstable-2025-09-15";

  src = fetchFromGitHub {
    owner = "wash2";
    repo = "cosmic_ext_bg_theme";
    rev = "884c3501458a1952e4c009fcc2fadf4e19014a2a";
    hash = "sha256-0QqMW8oW35U0/27bu4sOLju0C5DyvOV2i6vFbl2o6dA=";
  };

  cargoHash = "sha256-hRzk3gXKQCBqmlT5mXI34wRdPQLm8/A+Stw8ee4usAg=";

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
