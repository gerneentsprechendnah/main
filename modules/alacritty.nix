 
{
 inputs.alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  outputs = { nixpkgs, alacritty-theme, ... }: {
    nixosConfigurations.yourComputer =  nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ...}: {
          # install the overlay
          nixpkgs.overlays = [ alacritty-theme.overlays.default ];
        })
        ({ config, pkgs, ... }: {
          home-manager.users.stephan = hm: {
            programs.alacritty = {
              enable = true;
              # use a color scheme from the overlay
              settings.import = [ pkgs.alacritty-theme.cyber_punk_neon ];
            };
          };
        })
      ];
    };
  };
}
