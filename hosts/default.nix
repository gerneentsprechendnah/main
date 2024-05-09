
{inputs, vars, nixpkgs, nixpkgs-unstable, home-manager, nix-pandoc, nix-colors, hyprlock, hypridle, hyprland, home-manager-unstable, nur, nixgl, nixvim, nixvim-unstable, hyprspace, plasma-manager, ... }:

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

# DEPRECATED Desktop Profile
desktop = lib.nixosSystem {                               
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars hyprland nix-colors hyprlock hypridle hyprspace nix-pandoc;
      host = {
        hostName = "desktop";
        mainMonitor = "DP-1";
        secondMonitor = "DP-2";
      };
    };
    modules = [
     nur.nixosModules.nur
     nixvim.nixosModules.nixvim
     ./desktop
     ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.extraSpecialArgs = {
           inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
	        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
 

laptop = lib.nixosSystem {                                # Laptop Profile
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars hyprland nix-colors hyprlock hypridle hyprspace nix-pandoc;
      host = {
        hostName = "laptop";
        mainMonitor = "eDP-1";
        secondMonitor = "";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}

