{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook,
  atk,
  cairo,
  gdk-pixbuf,
  glib,
  gtk3,
  libxkbcommon,
  pango,
  vulkan-loader,
  stdenv,
  darwin,
  wayland,
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
    pkg-config
    wrapGAppsHook
  ];

  buildInputs =
    [
      atk
      cairo
      gdk-pixbuf
      glib
      gtk3
      libxkbcommon
      pango
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
    ]
    ++ lib.optionals stdenv.isLinux [
      wayland
    ];

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
