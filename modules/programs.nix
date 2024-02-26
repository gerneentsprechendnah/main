{ config, pkgs, ... }:
{
home-manager.users.stephan = {
    home.packages = [ 
      #pkgs.thunderbird-bin
      pkgs.betterbird
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
     # pkgs.swayidle
      pkgs.pandoc
      pkgs.texliveFull
      pkgs.onlyoffice-bin
      pkgs.libreoffice
      pkgs.zoom-us
      pkgs.nextcloud-client
      pkgs.mullvad-vpn
      pkgs.texmaker
      pkgs.python311Packages.pip
      pkgs.neovim
      pkgs.grim
      pkgs.grimblast
      pkgs.networkmanager-openvpn
      pkgs.openvpn3
      #pkgs.xfce.thunar
      pkgs.catppuccin-gtk
      pkgs.imagemagick
      pkgs.audio-recorder
      pkgs.audacity
      pkgs.nwg-dock-hyprland
      pkgs.pdfarranger
      pkgs.cinnamon.nemo-with-extensions
      pkgs.gtk4
      pkgs.gradience
      pkgs.xdg-desktop-portal-hyprland
      pkgs.obsidian
      pkgs.masterpdfeditor
      pkgs.brave
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
