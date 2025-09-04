{
  description = "A nix flake for installing a number of 3rd party applets for the Cosmic Desktop";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f nixpkgs.legacyPackages.${system});

    flake_attributes = forAllSystems (pkgs: rec {
      callPackage = name: pkgs.callPackage ./pkgs/${name}.nix {};
    
      applets = {
        cosmic-ext-applet-clipboard-manager = callPackage "cosmic-ext-applet-clipboard-manager";
        cosmic-ext-applet-caffeine = callPackage "cosmic-ext-applet-caffeine";
        cosmic-ext-applet-emoji-selector = callPackage "cosmic-ext-applet-emoji-selector";
        minimon-applet = callPackage "minimon-applet";
        cosmic-ext-applet-weather = callPackage "cosmic-ext-applet-weather";
        cosmic-ext-bg-theme = callPackage "cosmic-ext-bg-theme";
      };
    });
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (
      pkgs:
        flake_attributes.${pkgs.system}.applets
        // {
          # Make all applets available as individual packages
          # and create a default that includes all of them
          default = pkgs.buildEnv {
            name = "cosmic-applets-collection";
            paths = builtins.attrValues flake_attributes.${pkgs.system}.applets;
          };
        }
    );
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
