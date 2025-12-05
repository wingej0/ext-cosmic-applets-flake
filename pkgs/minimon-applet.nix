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
  pname = "minimon-applet";
  version = "unstable-2025-12-04";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "minimon-applet";
    rev = "cf21c963d971d8e6530c6a4af826db51d7cec270";
    hash = "sha256-ee1BlpDTf1nZj8ESPZhIo9+d/UuEUDbp22aBYTjacy8=";
  };

  cargoHash = "sha256-qgqlEufv9vLLIOcDLiX76xRcXal1Q0S5726ua+8R8Ek="; 

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
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-applet-minimon"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for displaying CPU/Memory/Network/Disk/GPU usage in the Panel or Dock";
    homepage = "https://github.com/cosmic-utils/minimon-applet";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "minimon-applet";
  };
}