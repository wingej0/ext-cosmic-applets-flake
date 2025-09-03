{
    description = "A nix flake for installing a number of 3rd party applets for the Cosmic Desktop";

    inputs = {

        # Essential inputs for building packages
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        cosmic-nix.url = "github:lily-may/cosmic-nix";

        # 3rd Party Applets to Build 
        cosmic-ext-applet-clipboard-manager = {
            url = "github:cosmic-utils/clipboard-manager";
            flake = false;
        };

        cosmic-ext-applet-caffeine = {
            url = "github:tropicbliss/cosmic-ext-applet-caffeine";
            flake = false;
        };

        cosmic-ext-applet-emoji-selector = {
            url = "github:bGVia3VjaGVu/cosmic-ext-applet-emoji-selector";
            flake = false;
        };

        minimon-applet = {
            url = "github:cosmic-utils/minimon-applet";
            flake = false;
        };

        cosmic-ext-applet-weather = {
            url = "github:cosmic-utils/cosmic-ext-applet-weather";
            flake = false;
        };

        cosmic-ext-bg-theme = {
            url = "github:wash2/cosmic_ext_bg_theme";
            flake = false;
        };

    };

    outputs = { self, nixpkgs, flake-utils, cosmic-nix, ... }@inputs:
        # Use flake-utils to easily support multiple systems (x86_64, aarch64, etc.)
        flake-utils.lib.eachDefaultSystem (system:
            let
                # 1. Get the package set for the current system
                pkgs = import nixpkgs {
                inherit system;

                # 2. Apply the COSMIC overlay to add COSMIC-specific packages
                overlays = [ cosmic-nix.overlays.default ];
            };

            # 3. Create a helper function to avoid repeating build logic
            buildCosmicApplet = { name, src, description, ... }:
                pkgs.rustPlatform.buildRustPackage {
                    pname = name;
                    inherit src;

                    nativeBuildInputs = with pkgs; [ pkg-config just ];

                    buildInputs = with pkgs; [
                        cosmic-protocols
                        cosmic-applet
                        dbus
                        freedesktop_desktop_entry
                        libsass
                        openssl
                        protobuf
                        gtk4
                        libadwaita
                    ];

                    cargoLock.lockFile = src + "/Cargo.lock";

                    meta = with pkgs.lib; {
                        inherit description;
                        homepage = "https://github.com/wingej0/ext-cosmic-applets-flake"; 
                        license = licenses.mit; 
                        maintainers = with maintainers; [ "wingej0" ]; 
                        platforms = platforms.linux;
                };
            };

            # 4. Define all your applet packages by calling the helper function
            applets = {
                cosmic-clipboard-manager = buildCosmicApplet {
                    name = "cosmic-clipboard-manager";
                    src = inputs.cosmic-ext-applet-clipboard-manager;
                    description = "A clipboard manager applet for COSMIC DE.";
                };
                cosmic-caffeine = buildCosmicApplet {
                    name = "cosmic-caffeine";
                    src = inputs.cosmic-ext-applet-caffeine;
                    description = "An applet to prevent the system from sleeping.";
                };
                cosmic-emoji-selector = buildCosmicApplet {
                    name = "cosmic-emoji-selector";
                    src = inputs.cosmic-ext-applet-emoji-selector;
                    description = "An emoji selector applet for COSMIC DE.";
                };
                cosmic-system-monitor = buildCosmicApplet {
                    name = "minimon-applet";
                    src = inputs.minimon-applet;
                    description = "A system resource monitor applet for COSMIC DE.";
                };
                cosmic-weather = buildCosmicApplet {
                    name = "cosmic-weather";
                    src = inputs.cosmic-ext-applet-weather;
                    description = "A weather forecast applet for COSMIC DE.";
                };
                cosmic-theme-creator = buildCosmicApplet {
                    name = "cosmic-wallpaper-creator";
                    src = inputs.cosmic-ext-bg-theme;
                    description = "A tool to create themes from wallpapers.";
                };
            };

            in
            # 5. Expose the packages and a development shell as the final outputs
            {
                # Make each applet individually buildable (e.g., `nix build .#cosmic-weather`)
                packages = applets;

                # Provide a development shell with all necessary tools
                devShells.default = pkgs.mkShell {
                buildInputs = with pkgs; [
                    rustc
                    cargo
                    clippy
                    rust-analyzer
                    just
                ] ++ (builtins.attrValues applets.cosmic-caffeine.buildInputs); # Reuse dependencies
            };
        });
}