{ config, pkgs, ... }:

{
home-manager.users.stephan = {


  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      screenshot = true;
      clock = true;
      ring-color = "bb00cc";
      indicator = true;
      indicator-idle-visible = true;
      indicator-caps-lock = true;
      indicator-radius = 100;
      indicator-thickness = 16;
      line-uses-inside = true;
      effect-blur = "9x7";
      effect-vignette = "0.85:0.85";
      fade-in = 0.1;
    };
  };

services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    timeouts = [
      {
        timeout = 10;
        command = "if pgrep -x swaylock; then hyprctl dispatch dpms off; fi";
        resumeCommand = "hyprctl dispatch dpms on";
      }
      {
        timeout = 900;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 1800;
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
      }
    ];
  };


};
}

