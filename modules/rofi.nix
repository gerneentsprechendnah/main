{ config, pkgs, ... }:
{

home-manager.users.stephan = {
	  programs.rofi = {
	    enable = true;
	    terminal = "${pkgs.cool-retro-term}/bin/cool-retro-term";
	    location = "center";
	    theme = ./theme.rasi;
	  };

	    home.file.".config/rofi/theme.rasi".text = ''

	    configuration {
		modi:				"drun";
		font:				"Rubik 10";
		show-icons:                     true;
		icon-theme: 			"Reversal-dark";
		display-drun: 			"";
		drun-display-format:            "{name}";
		sidebar-mode: 			false;
	}

	@theme "/dev/null"

	* {
	    font: "Montserrat 16";

	    bg0:  #24242480;
	    bg1:  #363636;
	    bg2:  #f5f5f520;
	    bg3:  #f5f5f540;
	    bg4:  #0860f2E6;

	    fg0:  #f5f5f5;
	    fg1:  #f5f5f580;

	    background-color: transparent;
	    text-color:       @fg0;
	    padding:          0px;
	    margin:           0px;
	}

	window {
	  fullscreen: true;
	  padding: 1em;
	  background-color: @bg0;
	}

	mainbox {
	  padding:  8px;
	}

	inputbar {
	  background-color: @bg2;

	  margin:   0px calc( 50% - 120px );
	  padding:  2px 4px;
	  spacing:  4px;

	  border:         1px;
	  border-radius:  2px;
	  border-color:   @bg3;

	  children: [icon-search,entry];
	}

	prompt {
	  enabled:  false;
	}

	icon-search {
	  expand:   false;
	  filename: "search";
	  vertical-align: 0.5;
	}

	entry {
	  placeholder:        "Search";
	  placeholder-color:  @bg2;
	}

	listview {
	  margin:   60px calc( 50% - 1200px );
	  spacing:  48px;
	  columns:  6;
	  fixed-columns: true;
	}

	element, element-text, element-icon {
	  cursor: pointer;
	}

	element {
	  padding:      8px;
	  spacing:      4px;

	  orientation:    vertical;
	  border-radius:  16px;
	}

	element selected {
	  background-color: @bg4;
	}

	element-icon {
	  size: 4em;
	  horizontal-align: 0.5;
	}

	element-text {
	  horizontal-align: 0.5;
	}
	    '';
    };
}
