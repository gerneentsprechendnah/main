#
#  Specific system configuration settings for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           ├─ bspwm.nix
#           └─ ./virtualisation
#               └─ docker.nix
#

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {                                  # Boot Options
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              # Grub Dual Boot
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find All Boot Options
        configurationLimit = 2;
      };
      timeout = 5;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.sane = {                         # Scanning
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

#  laptop.enable = true;                     # Laptop Modules
  hyprland.enable = true;                      # Window Manager

  environment = {
    systemPackages = with pkgs; [           # System-Wide Packages
      simple-scan       # Scanning
      onlyoffice-bin    # Office
    ];
  };

  programs.light.enable = true;             # Monitor Brightness

  services = {
    printing = {                            # Printing and drivers for TS5300
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
    };
  };
}

