{ config, pkgs, ...}: {
   users.users.stephan.isNormalUser = true;
  home-manager.users.stephan = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    home.packages = [ ];
   
    wayland.windowManager.sway.systemd.enable = true;
    wayland.windowManager.hyprland.systemd.enable = true;
    services.dunst.enable = true;
    programs.waybar.enable = true;
    programs.rofi.enable = true;
    programs.waybar.settings = [
    {
   
    font-family = "Roboto";
    border = "none";
    border-radius = "0px";
      
     "layer"= "top";
     "margin-bottom"= 0;
     "position"= "bottom";
     "margin-top"= 0;
     "margin-left"= 0;
     "margin-right"= 0;    
     "spacing"= 0;
     "modules-left" = [  "custom/appmenu" ];

}

    ];
    programs.waybar.style = ''  * {    border: none;    border-radius: 0;    font-family: Source Code Pro;  }  window#waybar {    background: #16191C;    color: #AAB2BF;  }  #workspaces button {    padding: 0 5px;  }'';
};
}
