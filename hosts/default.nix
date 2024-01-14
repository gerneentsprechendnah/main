
{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, hyprland, vars, ... }:

let
  system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
desktop = lib.nixosSystem {                               # DEPRECATED Desktop Profile
    inherit system;
    specialArgs = {
      inherit inputs system unstable hyprland vars;
      host = {
        hostName = "desktop";
        mainMonitor = "DP-1";
        secondMonitor = "DP-2";
      };
    };
    modules = [
      ./desktop
      ./configuration.nix
      ./home.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
