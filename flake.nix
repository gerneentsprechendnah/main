{
  description = "A very basic flake";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Unstable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Stable Nix Packages

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };
     
       hyprland = {                                                          # Official Hyprland Flake
        url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    };
     
   
     
     

   outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }:   # Function telling flake which inputs to use
    let
      vars = {                                                              # Variables Used In Flake
        user = "matthias";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
      };
     in
    {
      nixosConfigurations = (                                               # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager hyprland vars;   # Inherit inputs
        }
      );

 
    };
}

#  outputs = {self, nixpkgs, home-manager, ... }@inputs:
#     let
#       username = "stephan";
#       system = "x86_64-linux";
#       pkgs = import nixpkgs {
#         inherit system;
#        config.allowUnfree = true;
##         stateVersion = "23.11";
#	};
#       lib = nixpkgs.lib;
#      in {
       
      
#        nixosConfigurations = {
 #       specialArgs = { inherit inputs username system; };
#          "${username}" = lib.nixosSystem {
#             inherit system;
#             modules = [ 
#             ./configuration.nix
#             ./home.nix
#             home-manager.nixosModules.home-manager
#               {
#                home-manager.useGlobalPkgs = true;
#                home-manager.useUserPackages = true;
 #              }
 #            ];
#           };
#        };
        

#   };
#}
