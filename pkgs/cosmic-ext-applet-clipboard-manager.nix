{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  sqlite,
  vulkan-loader,
  stdenv,
  darwin,
  wayland,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-applet-clipboard-manager";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = version;
    hash = "sha256-TcTb3wFqw/WaxVsb4azqQAtc8unlc8xLXiupeiakxVg=";
  };

  cargoHash = "sha256-mFr2Zb48yKiv60UHBu9ZdbmR4X52Rp6HT8wGyxPpyYI=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      libxkbcommon
      sqlite
      vulkan-loader
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.CoreGraphics
      darwin.apple_sdk.frameworks.CoreServices
      darwin.apple_sdk.frameworks.Foundation
      darwin.apple_sdk.frameworks.Metal
      darwin.apple_sdk.frameworks.QuartzCore
      darwin.apple_sdk.frameworks.SystemConfiguration
    ]
    ++ lib.optionals stdenv.isLinux [
      wayland
    ];

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
