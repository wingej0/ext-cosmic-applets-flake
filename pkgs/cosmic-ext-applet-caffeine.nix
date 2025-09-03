{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-applet-caffeine";
  version = "unstable-2025-03-10";

  src = fetchFromGitHub {
    owner = "tropicbliss";
    repo = "cosmic-ext-applet-caffeine";
    rev = "dd52bc2974372bd2c4da49935aab0c108012580a";
    hash = "sha256-klaqJkigfzWokVVC2UWefE6AVvcrOi1Izvpc5FUxMGo=";
  };

  cargoHash = "sha256-xTJwVus28p7rNbfYRANo1UYkXDvwOc4ozuu+kPM3GDI=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [libxkbcommon];

  meta = {
    description = "Caffeine Applet for the COSMIC™ desktop";
    homepage = "https://github.com/tropicbliss/cosmic-ext-applet-caffeine/tree/main";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      wingej0
      gurjaka
    ];
    mainProgram = "cosmic-ext-applet-caffeine";
  };
}
