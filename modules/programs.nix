{ config, pkgs, ... }:
{
home-manager.users.stephan = {
    home.packages = [ 
      pkgs.thunderbird 
      pkgs.chromium 
      pkgs.typora 
      pkgs.bitwarden
      pkgs.gedit 
      pkgs.hyprland 
      pkgs.kitty 
      pkgs.dunst 
      pkgs.waybar
      pkgs.xdg-desktop-portal-hyprland
      pkgs.sway
      pkgs.hyprpaper
      pkgs.font-awesome
      pkgs.pywal
      pkgs.alacritty
      #pkgs.swaylock
      pkgs.swaylock-effects
      pkgs.wlroots
      pkgs.wlrctl
      pkgs.wlogout
      pkgs.swaybg
      pkgs.xdg-desktop-portal-gtk
      pkgs.swww
      pkgs.unzip
      pkgs.pywal
      pkgs.firefox
      pkgs.wofi
      pkgs.swayidle
      pkgs.pandoc
      pkgs.texliveFull
      pkgs.onlyoffice-bin
      pkgs.libreoffice
      pkgs.zoom-us
      pkgs.nextcloud-client
      pkgs.mullvad-vpn
      pkgs.texmaker
    ];
    services.dunst.enable = true;
    programs.waybar.enable = true;
    programs.rofi.enable = true;
 
   
    
 
    services.nextcloud-client = {
    enable = true;
   startInBackground = true;
  };
   
  };
}
