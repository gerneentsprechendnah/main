# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, unstable, inputs, vars, nix-colors, hyprlock, hypridle, ... }:



{
  imports =
    ( 
    import ../modules
    );
    users.users.${vars.user} = {
    home =  "/home/stephan";
    isNormalUser = true;
    description = "Stephan";
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
    };
 nixpkgs.config.permittedInsecurePackages = [
                "electron-24.8.6"
		"electron-25.9.0"
		];
 nixpkgs.config.allowUnfree = true;

nixpkgs.overlays = [ (final: prev: { obsidian-wayland = prev.obsidian.override {electron = final.electron_24;}; }) ];


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  
  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  coreutils
  killall
  lshw
  nix-tree
  usbutils
  xdg-utils
  git
  htop
  nano
  home-manager
  alsa-utils        # Audio Control
  feh               # Image Viewer
  mpv               # Media Player
  pavucontrol       # Audio Control
  pipewire          # Audio Server/Control
  pulseaudio        # Audio Server/Control
  vlc               # Media Player
  flatpak
  networkmanager
  networkmanagerapplet
  unstable.hypridle
  obsidian-wayland

  # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Browser
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
  
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

 # networking.hostName = "nixos"; # Define your hostname.

   # services
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    printing.enable = true;
    flatpak.enable = true;
  };



fonts.packages = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  networking.networkmanager.enable = true;

  
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;


  # services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome.enable = true;

 services.mullvad-vpn.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};

  system.stateVersion = "23.11"; # Did you read the comment?

  #system.autoUpgrade = {
  #  enable = true;
  #  channel = "https://nixos.org/channels/nixos-unstable";
  # };
  
  programs = {
    dconf.enable = true;
  };

  
 
environment.sessionVariables = {
  WLR_NO_HARDWARE_CURSORS = "1";
  NIXOS_OZONE_WL = "1";
};
 
 hardware = {
    opengl.enable = true;
};
 
 

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = { stateVersion = "23.11"; };
    programs = { home-manager.enable = true; };
    colorScheme = inputs.nix-colors.colorSchemes."${vars.theme}";
    imports = [
    inputs.nix-colors.homeManagerModules.default
    ];
  };

 programs.openvpn3.enable =true;

 programs.xfconf.enable = true;
 services.gvfs.enable = true; # Mount, trash, and other functionalities
 services.tumbler.enable = true; # Thumbnail support for images

  
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];




}

