{ config, pkgs, ... }:
{

home-manager.users.stephan = {
	  programs.rofi = {
	    enable = true;
	    terminal = "${pkgs.cool-retro-term}/bin/cool-retro-term";
	    location = "center";
	    theme = ./catppuccin-frappe.rasi;
	  };

	    home.file.".config/rofi/theme.rasi".text = ''

    configuration{
    modi: "run,drun,window";
    icon-theme: "Oranchelo";
    show-icons: true;
    terminal: "alacritty";
    drun-display-format: "{icon} {name}";
    location: 0;
    disable-history: false;
    hide-scrollbar: true;
    display-drun: "   Apps ";
    display-run: "   Run ";
    display-window: " 﩯  Window";
    display-Network: " 󰤨  Network";
    sidebar-mode: true;
    }
	@theme "/dev/null"

	    '';
    };
}
