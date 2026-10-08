{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  wayland,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-bg-theme";
  version = "unstable-2026-07-13";

  src = fetchFromGitHub {
    owner = "wash2";
    repo = "cosmic_ext_bg_theme";
    rev = "49f484b27bf2bcf66668d9401ec5a95727823281";
    hash = "sha256-56SNMPtLlAAYx6vlblyUNdVBOprs9nH+sKhPFx5IH1E=";
  };

  cargoHash = "sha256-TF2z+lGkAI0axMAJODVq6okB18uf1jPOVOnXP/rfeAU=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libxkbcommon
    wayland
  ];

  # Upstream tests add a second full dependency build for little coverage
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Automatically sets the COSMIC theme based on the current wallpaper";
    homepage = "https://github.com/wash2/cosmic_ext_bg_theme";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-bg-theme";
  };
}
