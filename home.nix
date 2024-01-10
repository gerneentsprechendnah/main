{ inputs, pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./programs.nix
    ./desktop.nix
    ./waybar.nix
    ./hyprland.nix
  ];
  }
