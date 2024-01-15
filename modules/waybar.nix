{ config, pkgs, ... }:
{ 
home-manager.users.stephan = {
	programs.waybar.settings  = [
	{  font-family = "Fira Sans Semibold FontAwesome Roboto Helvetica Arial sans-serif";
	/* Custom Modules */
	"custom/appmenu" = {
		"format" = "Apps";
		"on-click" = "rofi -show drun -replace";
		/* "on-click-right" = "~/dotfiles/hypr/scripts/keybindings.sh", */
		"tooltip" = false;
		};

	"hyprland/workspaces" = {
		"on-click" = "activate";
		"active-only" = false;
		"all-outputs" = true;
		"format" = "{}";
		"format-icons" = {
				"urgent" = "";
				"active" = "";
				"default" = "";
		};
		"persistent-workspaces" = {
	    "*" = 5;       
		};       
	    };
	     
	  "wlr/taskbar" = {
		"format" = "{icon}";
		"icon-size" = 18;
		"tooltip-format" = "{title}";
		"on-click" = "activate";
		"on-click-middle" = "close";
		"ignore-list" = [
		   "Alacritty"
		];
		"app_ids-mapping" = {
		    "firefoxdeveloperedition" = "firefox-developer-edition";
		};
		"rewrite" = {
		    "Firefox Web Browser" = "Firefox";
		    "Foot Server" = "Terminal";
		};
	    };
	    
	 "hyprland/window" = {
		"rewrite" = {
		    "(.*) - Brave" = "$1";
		    "(.*) - Chromium" = "$1";
		    "(.*) - Brave Search" = "$1";
		    "(.*) - Outlook" = "$1";
		    "(.*) Microsoft Teams" = "$1";
		};
		"separate-outputs" = true;
	    };

	     "custom/filemanager" = {
		"format" = "";
		"on-click" = "nautilus";
		"tooltip" = false; 
		};
	      
		"custom/exit" = {
		"format" = "󰐥";
		"on-click" = ''${pkgs.eww-wayland}/bin/eww open --toggle menu --screen 0'';
		"tooltip" = false;
		};
	    
	    
	    "layer" = "top"; /* Waybar at top layer */
	    "position" = "top"; /* Waybar position (top|bottom|left|right)*/
	    "height" = 24; /* Waybar height (to be removed for auto height)*/
	    "width" = 3840; /* Waybar width */
	    "spacing" = 4; /* Gaps between modules (4px) */
	    /* Choose the order of the modules */
	    "modules-left" = ["custom/exit" "custom/appmenu"  "custom/filemanager" "wlr/taskbar" "hyprland/window"];
	    "modules-center" = ["hyprland/workspaces" ];
	    "modules-right" = [ "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "clock" "tray" ];
	  
	    
	    "idle_inhibitor" = {
		"format" = "{icon}";
		"format-icons" = {
		    "activated" = "";
		    "deactivated" = "";
		};
	    };
	    "tray" = {
		 "icon-size" = 21;
		"spacing" = 10;
	    };
	   clock = {
              format = "{:%b %d %H:%M}  ";
              on-click = "sleep 0.1; ${pkgs.eww-wayland}/bin/eww open --toggle calendar --screen 0";
            };
	    "cpu" = {
		"format" = " {usage}% ";
		"on-click" = "alacritty -e htop";

	    };
	    "memory" = {
		"format" = " {}%";
	    };
	    "temperature" = {
		"thermal-zone" = 2;
		"hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
		"critical-threshold" = 80;
		"format-critical" = "{icon} {temperatureC}°C";
		"format" = "{icon} {temperatureC}°C";
		"format-icons" = ["" "" ""];
	    };
	    "backlight" = {
		/* "device" = "acpi_video1"; */
		"format" = "{icon} {percent}%";
		"format-icons" = ["" "" "" "" "" "" "" "" ""];
	    };
	    "battery" = {
		"states" = {
		    /* "good" = 95; */
		    "warning" = 30;
		    "critical" = 15;
		};
		"format" = "{icon} {capacity}%";
		"format-charging" = " {capacity}%";
		"format-plugged" = " {capacity}%";
		"format-alt" = "{icon} {time}";
		/* "format-good" = ""; */ /* An empty format will hide the module */
		/* "format-full" = ""; */
		"format-icons" = ["" "" "" "" ""];
	    };
	    "battery#bat2" = {
		"bat" = "BAT2";
	    };
	    "network" = {
		/* "interface" = "wlp2*"; */ /* (Optional) To force the use of this interface */
		"format-wifi" = "{essid} ({signalStrength}%) ";
		"format-ethernet" = " {ifname}";
		"tooltip-format" = " {ifname} via {gwaddr}";
		"format-linked" = " {ifname} (No IP)";
		"format-disconnected" = "Disconnected ⚠ {ifname}";
		"format-alt" = " {ifname} = {ipaddr}/{cidr}";
	    };
	    "pulseaudio" = {
		/* "scroll-step" = 1; */ /* %; can be a float */
		"format" = "{icon} {volume}% {format_source}";
		"format-bluetooth" = " {icon} {volume}% {format_source}";
		"format-bluetooth-muted" = "  {icon} {format_source}";
		"format-muted" = "  {format_source}";
		"format-source" = " {volume}%";
		"format-source-muted" = "";
		"format-icons" = {
	/*            "headphone" = "";
		      "hands-free" = "";
		      "headset" = "";
		      "phone" = "";
		      "portable" = "";
		      "car" = ""; */
		    "default" = ["" "" ""];
		};
		"on-click" = "pavucontrol";
	    };
	    
	}
	];
	programs.waybar.style = ''  
	* {    
	  border: none;    
	  border-radius: 0;    
	  font-family: Source Code Pro;  
	  }
	 
	window#waybar {
	    background-color: rgba(0,0,0,0.2);
	    border-bottom: 0px solid #ffffff;
	    /* color: #FFFFFF; */
	    transition-property: background-color;
	    transition-duration: .5s;
	}

	#workspaces {
	    background: #FFFFFF;
	    margin: 5px 1px 6px 1px;
	    padding: 0px 1px;
	    border-radius: 15px;
	    border: 0px;
	    font-weight: bold;
	    font-style: normal;
	    opacity: 0.8;
	    font-size: 16px;
	    color: #FFFFFF;
	}

	#workspaces button {
	    padding: 0px 5px;
	    margin: 4px 3px;
	    border-radius: 15px;
	    border: 0px;
	    color: #FFFFFF;
	    background-color: #5D7388;
	    transition: all 0.3s ease-in-out;
	    opacity: 0.4;
	}

	#workspaces button.active {
	    color: #FFFFFF;
	    background: #5D7388;
	    border-radius: 15px;
	    min-width: 40px;
	    transition: all 0.3s ease-in-out;
	    opacity:1.0;

	}
	#workspaces button:hover {
	    color: #FFFFFF;
	    background: #5D7388;
	    border-radius: 15px;
	    opacity:0.7;
	}

	tooltip {
	    border-radius: 10px;
	    background-color:  #FFFFFF;
	    opacity:0.8;
	    padding:20px;
	    margin:0px;
	}

	tooltip label {
	    color: #6F2A4C;
	}

	#window {
	    background: @backgroundlight;
	    margin: 8px 15px 8px 0px;
	    padding: 2px 10px 0px 10px;
	    border-radius: 12px;
	    color: #FFFFFF;
	    font-size:16px;
	    font-weight:normal;
	    opacity:0.8;
	}

	window#waybar.empty #window {
	    background-color:transparent;
	}

	#taskbar {
	    background:  #5D7388;
	    margin: 6px 15px 6px 0px;
	    padding:0px;
	    border-radius: 15px;
	    font-weight: normal;
	    font-style: normal;
	    opacity:0.8;
	    border: 3px solid  #FFFFFF;
	}
	#taskbar button {
	    margin:0;
	    border-radius: 15px;
	    padding: 0px 5px 0px 5px;
	}

	.modules-left > widget:first-child > #workspaces {
	    margin-left: 1em;
	}

	.modules-right > widget:last-child > #workspaces {
	    margin-right: 0;
	}

	#custom-appmenu {
	    background-color: #5D7388;
	    font-size: 16px;
	    color: #FFFFFF;
	    border-radius: 15px;
	    padding: 0px 10px 0px 10px;
	    margin: 6px 6px 6px 6px;
	    opacity:0.8;
	    border:3px solid #FFFFFF;
	}

	#idle_inhibitor {
	    margin-right: 15px;
	    font-size: 16px;
	    font-weight: bold;
	    opacity: 0.8;
	    color: #FFFFFF;
	}

	#idle_inhibitor.activated {
	    background-color: #dc2f2f;
	    font-size: 16px;
	    color: #FFFFFF;
	    border-radius: 15px;
	    padding: 2px 10px 0px 10px;
	    margin: 8px 15px 8px 0px;
	    opacity:0.8;  
	}

	#custom-exit {
	    margin: 6px 6px 6px 15px;
	    padding:0px;
	    font-size:24px;
	    color: @iconcolor;
	}

	#custom-brave, 
	#custom-browser, 
	#custom-keybindings, 
	#custom-outlook, 
	#custom-filemanager,
	#cpu, 
	#memory, 
	#custom-calculator, 
	#clock, 
	#custom-cliphist, 
	#network, 
	#pulseaudio, 
	#custom-wallpaper, 
	#custom-system,
	#custom-waybarthemes {
	    margin-right: 5px;
	    margin-left: 5px;
	    font-size: 16px;
	    font-weight: bold;
	    opacity: 0.8;
	    color: #FFFFFF;
	}


	'';

};

}

