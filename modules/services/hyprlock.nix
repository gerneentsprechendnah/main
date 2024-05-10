{ config, pkgs, lib, hyprlock, ... }:
{
home-manager.users.stephan = {
  imports =  [hyprlock.homeManagerModules.hyprlock];
  programs.hyprlock = {
  enable = true;
  };
 };
}
