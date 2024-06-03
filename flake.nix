{
  description = "Flake by Stephan";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";                     # latest Nix Packages (Default)

      nixpkgs-latest.url = "github:nixos/nixpkgs/nixos-unstable";         # Stable Nix Packages

      nix-pandoc.url = "github:serokell/nix-pandoc";

      nix-pandoc.inputs.nixpkgs.follows = "nixpkgs";

      nix-colors.url = "github:misterio77/nix-colors";

      nixos-hardware.url = "github:NixOS/nixos-hardware/master";     # linux hardware for surface go 3

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

        # latest User Environment Manager
      	home-manager-latest = {					     
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-latest";
      };

      firefox-addons = { 
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; 
        inputs.nixpkgs.follows = "nixpkgs"; 
      }; 

     # Official Hyprland Flake
      hyprland = {
        url = "github:hyprwm/Hyprland";
      };
      
          
      hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs-latest";
      };

      # NUR Community Packages
      nur = {
        url = "github:nix-community/NUR";
        # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      # Fixes OpenGL With Other Distros.
      nixgl = {
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Hyprspace
      hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
        inputs.nixpkgs.follows = "nixpkgs-latest";
      };

      # KDE Plasma User Settings Generator
      plasma-manager = {
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };




   outputs = inputs @ { self, nixpkgs, nixpkgs-latest, home-manager, nix-pandoc, nix-colors, hypridle, hyprland, home-manager-latest, nur, nixgl, hyprspace, plasma-manager, nixos-hardware, ... }:   # Function telling flake which inputs to use
    let
      vars = {                                                              # Variables Used In Flake
        user = "stephan";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
	theme = "catppuccin-frappe";
      };
     in
     {
      nixosConfigurations = (                                               # NixOS Configurations
          import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs self nixpkgs nixpkgs-latest home-manager nix-pandoc nix-colors hypridle hyprland home-manager-latest nur nixgl hyprspace plasma-manager vars nixos-hardware;   # Inherit inputs
          }
      );



  };
}

