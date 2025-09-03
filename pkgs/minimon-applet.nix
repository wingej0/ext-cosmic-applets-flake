{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
}:
rustPlatform.buildRustPackage rec {
  pname = "minimon-applet";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "minimon-applet";
    rev = "v${version}";
    hash = "sha256-TK+H9HUgJZxVwcxhot+Jsbs7ZnBBtu5p5xXEahzs298=";
  };

  cargoHash = "sha256-vNmySJ/bmSPpEHgIGTqs5Lf4GrhRfD6JdqVv+renUy8=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [libxkbcommon];

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
