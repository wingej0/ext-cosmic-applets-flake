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
  version = "unstable-2024-12-15";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "minimon-applet";
    rev = "main"; # Use latest commit since tags seem problematic
    hash = "sha256-FbbJPYotRHn85BV7p7wRSlAsPW1lSWrPCbEAgHq01QI="; # Reset this to get the correct hash for main branch
  };

  cargoHash = "sha256-d9vFKYtAoWFuYK2BcGx5X0PNWG2ICJFSowacB/qG1nY="; # Will need to be updated with actual hash

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