#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#

{ config, lib, system, pkgs, hyprland, vars, host, ... }:

let
  colors = import ./theming/colors.nix;
in
with lib;
with host;
{
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;                       # Wayland Window Manager

    environment =
    let
      exec = "exec dbus-launch Hyprland";
    in
    {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          ${exec}
        fi
      '';                                     # Start from TTY1

      variables = {
        #WLR_NO_HARDWARE_CURSORS="1";         # Needed for VM
        #WLR_RENDERER_ALLOW_SOFTWARE="1";
        XDG_CURRENT_DESKTOP="Hyprland";
        XDG_SESSION_TYPE="wayland";
        XDG_SESSION_DESKTOP="Hyprland";
      };
      sessionVariables = if hostName == "work" then {
        #GBM_BACKEND = "nvidia-drm";
        #__GL_GSYNC_ALLOWED = "0";
        #__GL_VRR_ALLOWED = "0";
        #WLR_DRM_NO_ATOMIC = "1";
        #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
        #_JAVA_AWT_WM_NONREPARENTING = "1";

        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
      } else {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };
      systemPackages = with pkgs; [
        grimblast       # Screenshot
        swayidle        # Idle Daemon
        swaylock        # Lock Screen
        wl-clipboard    # Clipboard
        wlr-randr       # Monitor Settings
      ];
    };

    security.pam.services.swaylock = {
      text = ''
       auth include login
      '';
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        };
      };
      vt = 7;
    };

    programs = {
      hyprland = {                            # Window Manager
        enable = true;
        package = hyprland.packages.${pkgs.system}.hyprland;
        #nvidiaPatches = if hostName == "work" then true else false;
      };
    };

    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=yes
    '';                                       # Clamshell Mode

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };                                        # Cache

    home-manager.users.${vars.user} =
    let
      touchpad =
        if hostName == "laptop" || hostName == "work" then ''
            touchpad {
              natural_scroll=true
              middle_button_emulation=true
              tap-to-click=true
            }
          }
          '' else "";
      gestures =
        if hostName == "laptop" || hostName == "work" then ''
          gestures {
            workspace_swipe=true
            workspace_swipe_fingers=3
            workspace_swipe_distance=100
          }
        '' else "";
      workspaces =
        if hostName == "desktop" || hostName == "beelink" then ''
          monitor=${toString mainMonitor},3840x2160@60,3840x0,1
          monitor=${toString secondMonitor},3840x2160@60,0x0,1
        '' else if hostName == "laptop" then ''
          monitor=${toString mainMonitor},2160x1440@60,0x0,1
        '' else ''
          monitor=${toString mainMonitor},1920x1080@60,0x0,1
        '';
      monitors =
        if hostName == "desktop" || hostName == "beelink" then ''
          workspace=${toString mainMonitor},1
          workspace=${toString mainMonitor},2
          workspace=${toString mainMonitor},3
          workspace=${toString mainMonitor},4
          workspace=${toString secondMonitor},5
          workspace=${toString secondMonitor},6
          workspace=${toString secondMonitor},7
          workspace=${toString secondMonitor},8
        '' else if hostName == "work" then ''
          workspace=${toString mainMonitor},1
          workspace=${toString mainMonitor},2
          workspace=${toString mainMonitor},3
          workspace=${toString secondMonitor},4
          workspace=${toString secondMonitor},5
          workspace=${toString secondMonitor},6
          workspace=${toString thirdMonitor},7

          bindl=,switch:Lid Switch,exec,$HOME/.config/hypr/script/clamshell.sh
        '' else "";
      execute =
        if hostName == "desktop" || hostName == "beelink" || hostName == "laptop" then ''
          exec-once=${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock --effect-blur 7x5' timeout 600 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -f && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
        '' else if hostName == "work" then ''
          exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
          #exec-once=${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse /GDrive
          exec-once=${pkgs.rclone}/bin/rclone mount --daemon gdrive: /GDrive
          exec-once=${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f' timeout 600 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -f && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
        '' else "";
    in
    let
      hyprlandConf = with colors.scheme.default.hex; ''
        ${workspaces}
        ${monitors}
        monitor=,preferred,auto,1,mirror,${toString mainMonitor}

    input {
    	kb_layout = de
    	kb_variant = 
    	kb_model = 
    	kb_options =
    	kb_rules =
    	kb_file = 
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

device:epic-mouse-v1 {
    sensitivity = -0.5
}
$mainMod = Mod4
bind = $mainMod, RETURN, exec, alacritty
bind = $mainMod, B, exec, firefox

# Windows
bind = $mainMod, Q, killactive
bind = $mainMod, L, exec, swaylock --effect-blur 7x5
bind = $mainMod, F, fullscreen
bind = $mainMod, E, exec, nautilus
bind = $mainMod, T, togglefloating
bind = $mainMod SHIFT, T, exec, hyprctl dispatch workspaceopt allfloat
bind = $mainMod, J, togglesplit
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
bind = $mainMod SHIFT, right, resizeactive, 100 0
bind = $mainMod SHIFT, left, resizeactive, -100 0
bind = $mainMod SHIFT, up, resizeactive, 0 -100
bind = $mainMod SHIFT, down, resizeactive, 0 100

# Actions

bind = $mainMod CTRL, RETURN, exec, rofi -show drun


# Workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
bind = $mainMod CTRL, down, workspace, empty

# Fn keys
bind = , XF86MonBrightnessUp, exec, brightnessctl -q s +10%
bind = , XF86MonBrightnessDown, exec, brightnessctl -q s 10%-
bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioPause, exec, playerctl pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous
bind = , XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
bind = , XF86Calculator, exec, qalculate-gtk
bind = , XF86Lock, exec, swaylock
bind = , XF86Tools, exec, alacritty --class dotfiles-floating -e ~/dotfiles/hypr/settings/settings.sh

# Passthrough SUPER KEY to Virtual Machine
bind = $mainMod, P, submap, passthru
submap = passthru
bind = SUPER, Escape, submap, reset
submap = reset


# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

        windowrulev2=float,title:^(Volume Control)$
        windowrulev2 = keepaspectratio,class:^(firefox)$,title:^(Picture-in-Picture)$
        windowrulev2 = noborder,class:^(firefox)$,title:^(Picture-in-Picture)$
        windowrulev2 = float, title:^(Picture-in-Picture)$
        windowrulev2 = size 24% 24%, title:(Picture-in-Picture)
        windowrulev2 = move 75% 75%, title:(Picture-in-Picture)
        windowrulev2 = pin, title:^(Picture-in-Picture)$
        windowrulev2 = float, title:^(Firefox)$
        windowrulev2 = size 24% 24%, title:(Firefox)
        windowrulev2 = move 74% 74%, title:(Firefox)
        windowrulev2 = pin, title:^(Firefox)$

        exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once=nextcloud
        exec-once= swaybg -i ~/Bilder/landscape.jpg -m fill
        exec-once=${pkgs.waybar}/bin/waybar
        exec-once=${pkgs.eww-wayland}/bin/eww daemon
        #exec-once=$HOME/.config/eww/scripts/eww        # When running eww as a bar
        exec-once=${pkgs.blueman}/bin/blueman-applet
        exec-once=${pkgs.swaynotificationcenter}/bin/swaync
        ${execute}
      '';
    in
    {
      xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;

#      programs.swaylock.settings = {
#      #image = "$HOME/.config/wall";
#        color = "000000f0";
#        indicator-idle-visible = false;
#        indicator-radius = 100;
#        indicator-thickness = 20;
#        inside-color = "00000000";
#        inside-clear-color = "00000000";
#        inside-ver-color = "00000000";
#        inside-wrong-color = "00000000";
#        key-hl-color = "79b360";
#        line-clear-color = "000000f0";
#        line-ver-color = "000000f0";
#        line-wrong-color = "000000f0";
#        ring-color = "ffffff50";
##        ring-clear-color = "bbbbbb50";
 #       ring-ver-color = "bbbbbb50";
#        ring-wrong-color = "b3606050";
#        text-color = "ffffff";
#        text-ver-color = "ffffff";
#        text-wrong-color = "ffffff";
#        show-failed-attempts = true;
#    };

  



   
    };
  };
}
