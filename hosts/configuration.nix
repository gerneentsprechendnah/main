# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, latest, inputs, vars, nix-colors, ... }:



{
  imports =
    ( 
    import ../modules
    );

    users.users.${vars.user} = {
    home =  "/home/stephan";
    uid = 1000;
    isSystemUser = true;
    group = "users";
    useDefaultShell = true;
    description = "Stephan";
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "vboxusers" ];
    };



    users.defaultUserShell = pkgs.zsh;
 
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
  
  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    noto-fonts # Google + Unicode
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];


  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    package = pkgs.nixVersions.latest;    # Enable Flakes
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
  nodejs
  xdg-utils         # Environment integration
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
  appimage-run
  latest.hypridle
  obsidian-wayland

    (catppuccin-gtk.override {
    accents = [ "lavender" ]; # You can specify multiple accents here to output multiple themes
    size = "compact";
    tweaks = [ "rimless" "black" ]; # You can also specify multiple tweaks here
    variant = "frappe";
  })

  # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Browsermicrosoft-surfac
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

  networking.networkmanager.enable = true;

  
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;


 services.mullvad-vpn.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "";
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

  system.stateVersion = "24.05"; # Did you read the comment?

  #system.autoUpgrade = {
  #  enable = true;
  #  channel = "https://nixos.org/channels/nixos-latest";
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
    home = { stateVersion = "24.05"; };
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

