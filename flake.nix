{
  description = "A nix flake for installing a number of 3rd party applets for the Cosmic Desktop";

  inputs = {
    # Essential inputs for building packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Applets
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
  		
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Import nixpkgs for the given system
        pkgs = import nixpkgs { inherit system; };

        # Helper function to call packages from the ./pkgs directory
        callPackage = name: pkgs.callPackage ./pkgs/${name}.nix {
          # Pass the source for the package from the inputs
          src = inputs."${name}";
        };

        # A set containing all your applet packages
        applets = {
          cosmic-ext-applet-clipboard-manager = callPackage "cosmic-ext-applet-clipboard-manager";
          cosmic-ext-applet-caffeine = callPackage "cosmic-ext-applet-caffeine";
          cosmic-ext-applet-emoji-selector = callPackage "cosmic-ext-applet-emoji-selector";
          minimon-applet = callPackage "minimon-applet";
          cosmic-ext-applet-weather = callPackage "cosmic-ext-applet-weather";
          cosmic-ext-bg-theme = callPackage "cosmic-ext-bg-theme";
        };
      in
      {
        # Packages exposed for building and installing
        # e.g., `nix build .#cosmic-ext-applet-caffeine`
        packages = applets // {
          # A default package that builds all applets
          default = pkgs.symlinkJoin {
            name = "cosmic-applets";
            paths = builtins.attrValues applets;
          };
        };

        # An overlay to easily add the applets to your system configuration
        overlays.default = final: prev: {
          cosmic-applets = applets;
        };
        
        # A dev shell for working on the packages
        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues applets ++ [
            pkgs.rustc
            pkgs.cargo
            pkgs.pkg-config
          ];
        };
      });      
}

