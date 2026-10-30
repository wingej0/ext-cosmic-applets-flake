{
  lib,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "signpost";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "lkbddh";
    repo = "Signpost";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ROb+qM+eCGU2SjypffWsjjHjbdkbygWnne4UwdQ6vMM=";
  };

  cargoHash = "sha256-Mx3GWonoaIa6fWpxIrDC7vUzt9ATnH9gZwZOp7RSf6s=";

  nativeBuildInputs = [libcosmicAppHook];

  doCheck = false;

  postInstall = ''
    substitute data/com.lkbddh.signpost.service.in com.lkbddh.signpost.service \
      --replace-fail "@bindir@" "$out/bin"
    install -Dm0644 com.lkbddh.signpost.service $out/share/dbus-1/services/com.lkbddh.signpost.service
    install -Dm0644 data/com.lkbddh.signpost.desktop -t $out/share/applications
    install -Dm0644 data/com.lkbddh.signpost.metainfo.xml -t $out/share/metainfo
    install -Dm0644 data/icons/com.lkbddh.signpost.svg -t $out/share/icons/hicolor/scalable/apps
    install -Dm0644 data/icons/com.lkbddh.signpost-symbolic.svg -t $out/share/icons/hicolor/symbolic/apps
  '';

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Link chooser for the COSMIC desktop";
    homepage = "https://github.com/lkbddh/Signpost";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "signpost";
  };
})
