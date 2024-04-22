{
  description = "Flake by Stephan";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Unstable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Stable Nix Packages
      hyprlock.url = "github:hyprwm/Hyprlock";
      nix-pandoc.url = "github:serokell/nix-pandoc";
      nix-pandoc.inputs.nixpkgs.follows = "nixpkgs";
      nix-colors.url = "github:misterio77/nix-colors";
      nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      firefox-addons = { 
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; 
        inputs.nixpkgs.follows = "nixpkgs"; 
        }; 
      hyprland = {                                                          # Official Hyprland Flake
       url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
       inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    

      hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    }; 

   outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nix-pandoc, nix-colors, hyprlock, hypridle, nixos-cosmic, hyprland, ... }:   # Function telling flake which inputs to use
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
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars nix-pandoc nix-colors hyprlock hypridle nixos-cosmic hyprland;   # Inherit inputs
          }
      );
  };
}

