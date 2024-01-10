wayland.windowManager.hyprland = {
  enable = true;
  extraConfig = ''
  
  '';
  settings = {
  "$terminal" = "kitty";
  "monitor "= "DP-2 3840x2160 3840x0 1";
  "monitor" = "HDMI-A-1 3840x2160 0x0 1";
  "general" = {
    "gaps_in" = "10"
    "gaps_out" = "14"
    "border_size" = "3"
    "col.active_border" = "$color11"
    "col.inactive_border" = "rgba(ffffffff)"
    "layout" = "dwindle"
}
  };
};
