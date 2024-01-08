{ config, pkgs, ... }:
let
  home-manager = (builtins.fetchTarball {
  url= "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  sha256 = "1a19f91vkpdi95l39fplrl3kfxmknkmbys4qi3fxibj751slm0y8";});
in
{
  imports = [
    (import "${home-manager}/nixos")
    ( import "/home/stephan/flake/desktop.nix")
  ];
 
 


  home-manager.users.stephan = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    home.packages = [ pkgs.thunderbird pkgs.chromium pkgs.typora ];
  };
}
