#
#  Gnome Configuration
#  Enable with "gnome.enable = true;"
#

{ config, lib, pkgs, vars, ... }:

with lib;
{
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    programs = {
      zsh.enable = true;
      kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    };

    services = {
       libinput.enable = true;
      xserver = {
        enable = true;
        
        xkb.layout = "de";
        xkb.options = "eurosign:e";
       
        modules = [ pkgs.xf86_input_wacom ];
        wacom.enable = true;

        displayManager.gdm = {
         enable = true;
         wayland = true;
        };
        desktopManager.gnome = {
          enable = true;
          extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
          extraGSettingsOverrides = ''
           [org.gnome.mutter]
           experimental-features=['scale-monitor-framebuffer']
           '';
        };
      };
      udev.packages = with pkgs; [
        gnome.gnome-settings-daemon
      ];
    };

    environment = {
      systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnome.dconf-editor
        gnome.gnome-tweaks
        pkgs.gnome.gnome-control-center
        pkgs.gnome-console
      ];
      gnome.excludePackages = (with pkgs; [
        gnome-tour
      ]) ++ (with pkgs.gnome; [
        atomix
        epiphany
        geary
        gnome-characters
        gnome-contacts
        gnome-initial-setup
        hitori
        iagno
        tali
        yelp
      ]);
    };

    home-manager.users.${vars.user} = {
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = [
            "org.gnome.Settings.desktop"
            "gnome-terminal.desktop"
            "firefox.desktop"
            "thunderbird.desktop"
            "obsidian.desktop"
            "nautilus.desktop"
            "typora.desktop"
            "com.obsproject.studio.desktop"
            "plexmediaplayer.desktop"
            "virt-manager.desktop"
            
            # "blueman-manager.desktop"
            # "pavucontrol.desktop"
          ];
          disable-user-extensions = false;
          enabled-extensions = [
            "trayiconsreloaded@selfmade.pl"
            "blur-my-shell@aunetx"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "dash-to-panel@jderose9.github.com"
            "just-perfection-desktop@just-perfection"
            "caffeine@patapon.info"
            "clipboard-indicator@tudmotu.com"
            "horizontal-workspace-indicator@tty2.io"
            "bluetooth-quick-connect@bjarosze.gmail.com"
            
            "gsconnect@andyholmes.github.io"
            "pip-on-top@rafostar.github.com"
            "forge@jmmaranan.com"
            "pop-shell"
            "dash-to-dock@micxgx.gmail.com" # Alternative Dash-to-Panel
            # "fullscreen-avoider@noobsai.github.com" # Dash-to-Panel Incompatable
          ];
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          clock-show-weekday = true;
          # gtk-theme = "adwaita-dark";
        };
        # "org/gnome/desktop/session" = { # Not Working
        #   idle-delay = "uint32 900";
        # };
        "org/gnome/desktop/privacy" = {
          report-technical-problems = "false";
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          action-right-click-titlebar = "toggle-maximize";
          action-middle-click-titlebar = "minimize";
          resize-with-right-button = true;
          mouse-button-modifier = "<super>";
          button-layout = ":minimize,close";
        };
        "org/gnome/desktop/wm/keybindings" = {
          # maximize = ["<super>up"]; # Floating
          # unmaximize = ["<super>down"];
          maximize = [ "@as []" ]; # Tiling
          unmaximize = [ "@as []" ];
          switch-to-workspace-left = [ "<alt>left" ];
          switch-to-workspace-right = [ "<alt>right" ];
          switch-to-workspace-1 = [ "<alt>1" ];
          switch-to-workspace-2 = [ "<alt>2" ];
          switch-to-workspace-3 = [ "<alt>3" ];
          switch-to-workspace-4 = [ "<alt>4" ];
          switch-to-workspace-5 = [ "<alt>5" ];
          move-to-workspace-left = [ "<shift><alt>left" ];
          move-to-workspace-right = [ "<shift><alt>right" ];
          move-to-workspace-1 = [ "<shift><alt>1" ];
          move-to-workspace-2 = [ "<shift><alt>2" ];
          move-to-workspace-3 = [ "<shift><alt>3" ];
          move-to-workspace-4 = [ "<shift><alt>4" ];
          move-to-workspace-5 = [ "<shift><alt>5" ];
          move-to-monitor-left = [ "<super><alt>left" ];
          move-to-monitor-right = [ "<super><alt>right" ];
          close = [ "<super>q" "<alt>f4" ];
          toggle-fullscreen = [ "<super>f" ];
        };

        "org/gnome/mutter" = {
          workspaces-only-on-primary = false;
          center-new-windows = true;
          edge-tiling = false; # Tiling
        };
        "org/gnome/mutter/keybindings" = {
          #toggle-tiled-left = ["<super>left"]; # Floating
          #toggle-tiled-right = ["<super>right"];
          toggle-tiled-left = [ "@as []" ]; # Tiling
          toggle-tiled-right = [ "@as []" ];
        };

        "org/gnome/settings-daemon/plugins/power" = {
          sleep-interactive-ac-type = "nothing";
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<super>return";
          command = "alacritty";
          name = "open-terminal";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<super>t";
          command = "emacs";
          name = "open-editor";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          binding = "<super>e";
          command = "nautilus";
          name = "open-file-browser";
        };

       # "org/gnome/shell/extension/dash-to-panel" = {
        # Set Manually
        #  panel-position = ''{"0":"top","1":"top"}'';
        #  panel-sizes = ''{"0":24,"1":24}'';
        #  panel-element-positions-monitors-sync = true;
        #  appicon-margin = 0;
        #  appicon-padding = 4;
        #  dot-position = "top";
        #  dot-style-focused = "solid";
        #  dot-style-unfocused = "dots";
        #  animate-appicon-hover = true;
        #  animate-appicon-hover-animation-travel = "{'simple': 0.14999999999999999, 'ripple': 0.40000000000000002, 'plank': 0.0}";
        #  isolate-monitors = true;
        #};
        "org/gnome/shell/extensions/just-perfection" = {
          theme = true;
          activities-button = false;
          app-menu = false;
          clock-menu-position = 0;
          clock-menu-position-offset = 7;
        };
        "org/gnome/shell/extensions/caffeine" = {
          enable-fullscreen = true;
          restore-state = true;
          show-indicator = true;
          show-notification = false;
        };
        "org/gnome/shell/extensions/blur-my-shell" = {
          brightness = 0.9;
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          customize = true;
          sigma = 0;
        };
        "org/gnome/shell/extensions/blur-my-shell/overview" = {
          customize = true;
          sigma = 0;
        };
        "org/gnome/shell/extensions/horizontal-workspace-indicator" = {
          widget-position = "left";
          widget-orientation = "horizontal";
          icons-style = "circles";
        };
       
        "org/gnome/shell/extensions/pip-on-top" = {
          stick = true;
        };
        "org/gnome/shell/extensions/forge" = {
          window-gap-size = 8;
          dnd-center-layout = "stacked";
        };
        "org/gnome/shell/extensions/forge/keybindings" = {
          # Set Manually
          focus-border-toggle = true;
          float-always-on-top-enabled = true;
          window-focus-up = [ "<super>up" ];
          window-focus-down = [ "<super>down" ];
          window-focus-left = [ "<super>left" ];
          window-focus-right = [ "<super>right" ];
          window-move-up = [ "<shift><super>up" ];
          window-move-down = [ "<shift><super>down" ];
          window-move-left = [ "<shift><super>left" ];
          window-move-right = [ "<shift><super>right" ];
          window-swap-last-active = [ "@as []" ];
          window-toggle-float = [ "<shift><super>f" ];
        };
         "org/gnome/shell/extensions/dash-to-dock" = { # If Dock Preferred
           multi-monitor = true;
           dock-fixed = false;
           dash-max-icon-size = 48;
           custom-theme-shrink = true;
           transparency-mode = "dynamic";
           intellihide-mode = "ALL_WINDOWS";
           autohide = true;
           background-opacity = 0.0;
           show-apps-at-top = true;
           show-trash = true;
           hot-keys = false;
           click-action = "previews";
           scroll-action = "cycle-windows";
           show-favorites = true;
         };
       
      };

      home.packages = with pkgs.gnomeExtensions; [
        tray-icons-reloaded
        blur-my-shell
        removable-drive-menu
        dash-to-panel
        dash-to-dock
        
        just-perfection
        caffeine
        clipboard-indicator
        workspace-indicator-2
        bluetooth-quick-connect
        gsconnect
        pip-on-top
        pop-shell
        forge
        # fullscreen-avoider
         dash-to-dock
      ];
    };
  };



}