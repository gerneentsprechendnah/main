{ config, pkgs, ... }:
{ 
users.users.stephan.isNormalUser = true;
home-manager.users.stephan = {
/* The home.stateVersion option does not have a default and must be set */
home.stateVersion = "23.11";

wayland.windowManager.hyprland = {
  enable = true;
  extraConfig = ''
    monitor = DP-2, 3840x2160, 3840x0, 1
    monitor = HDMI-A-1, 3840x2160, 0x0, 1
    
    $fileManager = dolphin
    $menu = rofi -show drun
    $terminal = kitty
    
    $mainMod  = ALT
    $mainMod, Return, exec, alacritty
    $mainMod, E, exec, nautilus
    input {
    	kb_layout = de
    	kb_variant = 
    	kb_model = pc104
    	kb_options = terminate:ctrl_alt_bksp
    	kb_rules =
    	kb_file = /etc/00-keyboard.conf
    	follow_mouse = 1
    	}
    general {
        gaps_in = 5
    	gaps_out = 20
    	border_size = 2
    	col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    	col.inactive_border = rgba(595959aa)
    	layout = dwindle
    	allow_tearing = false
    	}
    decoration {
    	rounding = 10
    	blur {
        	enabled = true
        	size = 3
        	passes = 1
    		}
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    new_is_master = true
}

gestures {
    workspace_swipe = off
}



device:epic-mouse-v1 {
    sensitivity = -0.5
}

windowrulev2 = nomaximizerequest, class:.*

  '';
  settings = {
  exec-once = [
        "nm-applet"
        "swaybg -i ~/Bilder/wallpaper.jpg -m fill"
        "waybar"
        "dunst"
      ];
  

  
     
    };
  };
};
}
