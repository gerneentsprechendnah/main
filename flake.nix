{
  description = "A very basic flake";
  
  inputs = {
     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
     hyprland.url = "github:hyprwm/Hyprland";
     home-manager.url = "github:nix-community/home-manager";
     home-manager.inputs.nixpkgs.follows = "nixpkgs";
     };

  outputs = {self, nixpkgs, home-manager, ... }:
     let
       system = "x86_64-linux";
       pkgs = import nixpkgs {
         inherit system;
         config.allowUnfree = true;
         stateVersion = "23.11";
	};
      lib = nixpkgs.lib;
      in {
        nixosConfigurations = {
          stephan = lib.nixosSystem {
             inherit system;
             modules = [ 
             ./configuration.nix
             ./home.nix
             home-manager.nixosModules.home-manager
               {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
               }
             ];
           };
        };
        
       
        
        };
}
