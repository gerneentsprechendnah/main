{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ swayidle ];

  settings.lock.bin = "swaylock";

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      image = "${config.settings.wallpaper}";
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

  settings.lock.idle = builtins.concatStringsSep " " [
    "swayidle -w"
    "timeout 450 'swaylock -f'"
    "before-sleep 'swaylock -f'"
  ];
}

