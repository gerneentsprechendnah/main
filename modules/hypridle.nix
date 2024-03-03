{ config, pkgs, lib, hypridle, ... }:
{
home-manager.users.stephan = {
  imports =  [hypridle.homeManagerModules.hypridle];
  programs.hypridle.enable = true;





programs = {
      hypridle = {                            # Window Manager
        package = hypridle.packages.${pkgs.system}.hypridle;
};
};
}
}
