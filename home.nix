{ inputs, pkgs, home-manager, ... }:
{



  imports = [
    ./desktop.nix
    ./programs.nix
    ./desktop.nix
    ./waybar.nix
    ./hyprland.nix
    ./rofi.nix
    ./wlogout.nix
  ];
  
  
  }
  
