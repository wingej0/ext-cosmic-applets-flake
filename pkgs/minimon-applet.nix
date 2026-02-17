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
  version = "unstable-2026-02-14";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "minimon-applet";
    rev = "6259472e7d97d0085d9d7325244ea69a7893c993";
    hash = "sha256-DbGOJXF6gz2Z7p3vZZ881br/q/X3lSPfkIzhw0bFQEA=";
  };

  cargoHash = "sha256-pwoJP9vfyMKxvFQ4Rabl3VKtP14ks5jlUw0xz1OTl3A="; 

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