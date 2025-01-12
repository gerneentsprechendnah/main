#
#  Bar
#

{ inputs, config, lib, pkgs, vars, host, nix-colors, home-manager, ...}:
with host;
let
  modules-left =  [ "custom/appmenu" "wlr/taskbar" "hyprland/window" ];


  modules-right =
    if hostName == "beelink" || hostName == "desktop" then [
      "custom/themeselector" "custom/notification" "tray" "custom/exit"
    ] else [
      "custom/themeselector" "custom/notification" "tray" "custom/exit" 
      ];

  modules-center =
    if hostName == "beelin" || hostName == "desktop" then [
       "network" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "clock"
      ] else [
       "network" "backlight" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "battery" "clock"
       ];

in
{
colorScheme = inputs.nix-colors.colorSchemes."${vars.theme}";
imports = [
    inputs.nix-colors.homeManagerModules.default
    ];
home-manager.users.stephan = {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = modules-left; 
      modules-center = modules-center;
      modules-right = modules-right;
      "hyprland/workspaces" = {
      	format = "{icon}";
      	format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = "{:%b %d %H:%M}";
      	tooltip = false;
        on-click = "sleep 0.1; ${pkgs.eww}/bin/eww open --toggle calendar --screen 0";
      };
      "hyprland/window" = {
      	max-length = 60;
      	separate-outputs = false;
      };
      "memory" = {
      	interval = 5;
      	format = " {}%";
        tooltip = true;
      };
      "cpu" = {
      	interval = 5;
      	format = " {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = "  {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = ": {bandwidthDownOctets} : {bandwidthUpOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = {
        spacing = 12;
      };
      "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";

          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "custom/themeselector" = {
        tooltip = false;
        format = "";
        on-click = "theme-selector";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
      "custom/appmenu" = {
	format = "Apps";
	on-click = "rofi -i -show drun -modi drun -show-icons";
        tooltip = false;
	};
      "custom/exit" = {
	format = "󰐥";
	on-click = ''${pkgs.eww}/bin/eww open --toggle menu --screen 0'';
	tooltip = false;
	};
      
       "backlight" = {
	/* "device" = "acpi_video1"; */
	format = "{icon} {percent}%";
	format-icons = ["" "" "" "" "" "" "" "" ""];
	    };

        "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 18;
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        ignore-list = [
           "Alacritty"
        ];
        app_ids-mapping = {
            "firefoxdeveloperedition" = "firefox-developer-edition";
        };
        rewrite = {
            "Firefox Web Browser" = "Firefox";
            "Foot Server" = "Terminal";
        };
    };	    


    }];
    style = ''
	* {
		font-size: 16px;
		font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
    		font-weight: bold;
	}
	window#waybar {
		    background-color: rgba(26,27,38,0);
    		border-bottom: 1px solid rgba(26,27,38,0);
    		border-radius: 0px;
		    color: #${config.colorScheme.colors.base0F};
	}
	#workspaces {
		    background: linear-gradient(180deg, #${config.colorScheme.colors.base00}, #${config.colorScheme.colors.base01});
    		margin: 5px;
    		padding: 0px 1px;
    		border-radius: 15px;
    		border: 0px;
    		font-style: normal;
    		color: #${config.colorScheme.colors.base00};
	}
	#workspaces button {
    		padding: 0px 5px;
    		margin: 4px 3px;
    		border-radius: 15px;
    		border: 0px;
    		color: #${config.colorScheme.colors.base00};
    		background-color: #${config.colorScheme.colors.base00};
    		opacity: 1.0;

    		transition: all 0.3s ease-in-out;
	}
	#workspaces button.active {
    		color: #${config.colorScheme.colors.base00};
    		background: #${config.colorScheme.colors.base04};
    		border-radius: 15px;
    		min-width: 40px;
    		transition: all 0.3s ease-in-out;
    		opacity: 1.0;
	}
	#workspaces button:hover {
    		color: #${config.colorScheme.colors.base00};
    		background: #${config.colorScheme.colors.base04};
    		border-radius: 15px;
    		opacity: 1.0;
	}
	tooltip {
  		background: #${config.colorScheme.colors.base00};
  		border: 1px solid #${config.colorScheme.colors.base04};
  		border-radius: 10px;
	}
	tooltip label {
  		color: #${config.colorScheme.colors.base07};
	}
	#window {
    		color: #${config.colorScheme.colors.base05};
    		background: #${config.colorScheme.colors.base00};
    		margin: 5px 5px 5px 0px;
    		border-radius: 50px 15px 50px 15px;
    		padding: 2px 20px;
	}
	#memory {
    		color: #${config.colorScheme.colors.base0F};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#clock {
    		color: #${config.colorScheme.colors.base0B};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
		
	}
	#cpu {
    		color: #${config.colorScheme.colors.base07};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#disk {
    		color: #${config.colorScheme.colors.base03};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#battery {
    		color: #${config.colorScheme.colors.base08};
    		background: #${config.colorScheme.colors.base00};
                border-radius: 15px 50px 15px 50px; 	
		margin: 5px;
    		padding: 2px 20px;
	}
		#backlight {
    		color: #${config.colorScheme.colors.base08};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#network {
    		color: #${config.colorScheme.colors.base09};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 50px 15px 50px 15px;

    		margin: 5px;
    		padding: 2px 20px;
	}
	#tray {
    		color: #${config.colorScheme.colors.base05};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
	#pulseaudio {
    		color: #${config.colorScheme.colors.base0D};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#custom-notification {
    		color: #${config.colorScheme.colors.base0C};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
         	}
       #custom-themeselector {
    		color: #${config.colorScheme.colors.base0D};
    		background: transparent;
    		border-radius: 5px;
    		margin: 5px;
    		padding: 2px 2px;
                }
        #custom-appmenu {
		color: #${config.colorScheme.colors.base0B};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 0px 15px 50px 0px;
    		margin: 5px 5px 5px 0px;
    		padding: 2px 20px;
         	} 
    	#custom-exit {
    		color: #${config.colorScheme.colors.base05};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 15px 0px 0px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
	#taskbar {
                color: #${config.colorScheme.colors.base0B};
    		background: #${config.colorScheme.colors.base00};
    		border-radius: 50px 15px 50px 0px;
    		margin: 5px 5px 5px 0px;
    		padding: 2px 20px;
          	}

    '';
  };
 };
}
