{ config, pkgs, home-manager,  ... }:
{
home-manager.users.stephan = {
    home.packages = [ 
      #pkgs.thunderbird-bin
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
      pkgs.hyprpaper
      pkgs.font-awesome
      pkgs.pywal
      pkgs.alacritty
      pkgs.wlroots
      pkgs.wlrctl
      pkgs.swaybg
      pkgs.xdg-desktop-portal-gtk
      pkgs.swww
      #pkgs.unzip
      #pkgs.firefox
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
      pkgs.catppuccin-gtk
      pkgs.imagemagick
      pkgs.audio-recorder
      pkgs.audacity
      pkgs.nwg-dock-hyprland
      pkgs.pdfarranger
      pkgs.obsidian
      pkgs.masterpdfeditor
      ];

    services.dunst.enable = true;
    programs.waybar.enable = true;
    programs.rofi.enable = true;
    services.nextcloud-client = {
    enable = true;
    startInBackground = true;
    };
    

    accounts.email.accounts.gmail = {
    primary = true;
    address = "stephan.ritthaler@gmail.com";
    thunderbird.enable = true;
    realName = "Stephan Ritthaler";
};
  };
   

   nix.gc.automatic = true;   
   nix.gc.options = "--delete-older-than 10d";
}
