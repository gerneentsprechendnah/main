{
  description = "Flake by Stephan";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Unstable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Stable Nix Packages
      nix-pandoc.url = "github:serokell/nix-pandoc";
      nix-pandoc.inputs.nixpkgs.follows = "nixpkgs";
      nix-colors.url = "github:misterio77/nix-colors";
      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };
     
       hyprland = {                                                          # Official Hyprland Flake
       url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
       inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    };
     

   outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, nix-pandoc, nix-colors, ... }:   # Function telling flake which inputs to use
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
          inherit inputs nixpkgs nixpkgs-unstable home-manager hyprland vars nix-pandoc nix-colors;   # Inherit inputs
          }
      );
  };
}

