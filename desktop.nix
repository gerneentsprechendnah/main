{ config, pkgs, ...}: {
   users.users.stephan.isNormalUser = true;
  home-manager.users.stephan = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    home.packages = [ 
    ];
    
    };
}
