#
#  GTK
#

{ pkgs, vars, config, host, ... }:

{
  home-manager.users.${vars.user} =
  {
    home = {
      sessionVariables.GTK_THEME = "Catppuccin-Frappe-Standard-Lavender-Dark";
      file.".config/wall.png".source = ./wallpaper/wave-ctppccn-mocha-maroon.png;
      file.".config/wall.mp4".source = ./wall.mp4;
      pointerCursor = {                     # System-Wide Cursor
        gtk.enable = true;
        #name = "Dracula-cursors";
        name = "Catppuccin-Frappe-Lavender-Cursors";
        #package = pkgs.dracula-theme;
        package = pkgs.catppuccin-cursors.frappeLavender;
        size = 24;
      };
    };
#    gtk = {                                 # Theming
#      enable = true;
#      theme = {
#        #name = "Dracula";
#        #name = "Catppuccin-Mocha-Compact-Blue-Dark";
#        name = "Orchis-Dark-Compact";
        #package = pkgs.dracula-theme;
        # package = pkgs.catppuccin-gtk.override {
        #   accents = ["blue"];
        #   size = "compact";
        #   variant = "mocha";
        # };
#        package = pkgs.orchis-theme;
#     };


gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "frappe";
	      };
	          };
  



      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "frappe";
	  accent = "lavender";
	};
        };
      font = {
        name = "Roboto";
      };
   
    };


   xdg = {
      enable = true;
      configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor = 
      path = /home/stephan/.config/wall.png   # only png supported for now
      color = rgba(25, 20, 20, 1.0)

    # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
    blur_passes = 4 # 0 disables blurring
    blur_size = 2
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
    }

    input-field {
    monitor =
    size = 200, 50
    outline_thickness = 1
    dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true
    outer_color = rgb(000000)
    inner_color = rgb(200, 200, 200)
    font_color = rgb(10, 10, 10)
    fade_on_empty = true
    placeholder_text = <i>Passwort eingeben...</i> # Text rendered in the input box when it's empty.
    hide_input = false
    position = 0, -20
    halign = center
    valign = center
    }

    label {
    monitor =
    text = Zum Entsperren Passwort eingeben
    color = rgba(200, 200, 200, 1.0)
    font_size = 25
    font_family = Noto Sans

    position = 0, 200
    halign = center
    valign = center
    }
       '';

    configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/wall.png
    wallpaper = DP-1,~/.config/wall.png 
    wallpaper = DP-2,~/.config/wall.png
    wallpaper = eDP-1,~/.config/wall.png
    ipc = on       
       '';


    };  

    qt.enable = true;
    qt.platformTheme = "gtk";
    qt.style.name = "adwaita-dark";
    qt.style.package = pkgs.adwaita-qt;
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME="gtk2";
   };

}
