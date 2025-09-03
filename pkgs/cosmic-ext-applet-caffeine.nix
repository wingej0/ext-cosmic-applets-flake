{ lib, stdenv, rustPlatform, pkg-config, src, just, libcosmicAppHook, nix-update-script }:

rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-applet-caffeine";
  version = "0.1.0";

  inherit src;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-Ynqb71OnHULvouvulBKQBo41j61aQpLoHnCJwJihTrY=";
  };

  nativeBuildInputs = [
    pkg-config
    just
    libcosmicAppHook
  ];

  # This package uses a `justfile` for its build process instead of raw cargo commands.
  # These flags replicate the logic from the working example.
  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set" "prefix" (placeholder "out")
    "--set" "bin-src" "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-caffeine"
  ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Caffeine Applet for the COSMIC desktop";
    homepage = "https://github.com/tropicbliss/cosmic-ext-applet-caffeine";
    # The repository's LICENSE file specifies GPLv3.
    license = licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = platforms.linux;
    mainProgram = "cosmic-ext-applet-caffeine";
  };
}

