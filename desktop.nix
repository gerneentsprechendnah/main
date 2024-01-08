{ config, pkgs, ...}: {
  home-manager.users.stephan = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
  home.packages = [ pkgs.gedit ];
};
}
