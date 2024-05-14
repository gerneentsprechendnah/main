{
  description = "Flake by Stephan";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Unstable Nix Packages (Default)

      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Stable Nix Packages

      hyprlock.url = "github:hyprwm/Hyprlock";

      nix-pandoc.url = "github:serokell/nix-pandoc";

      nix-pandoc.inputs.nixpkgs.follows = "nixpkgs";

      nix-colors.url = "github:misterio77/nix-colors";

      nixos-hardware.url = "github:NixOS/nixos-hardware/master";     # linux hardware for surface go 3

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

        # Unstable User Environment Manager
      	home-manager-unstable = {					     
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      # Neovim
      nixvim = {
        url = "github:nix-community/nixvim/nixos-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Neovim
      nixvim-unstable = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      # Hyprspace
      hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      # KDE Plasma User Settings Generator
      plasma-manager = {
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };




   outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nix-pandoc, nix-colors, hyprlock, hypridle, hyprland, home-manager-unstable, nur, nixgl, nixvim, nixvim-unstable, hyprspace, plasma-manager, nixos-hardware, ... }:   # Function telling flake which inputs to use
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
          inherit inputs self nixpkgs nixpkgs-unstable home-manager nix-pandoc nix-colors hyprlock hypridle hyprland home-manager-unstable nur nixgl nixvim nixvim-unstable hyprspace plasma-manager vars nixos-hardware;   # Inherit inputs
          }
      );



  };
}

