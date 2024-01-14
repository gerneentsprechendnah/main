# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, username, ... }:

let
  user = "stephan";
in

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration.nix
     #./hyperland.nix
    ];

   
  # Bootloader.
 boot = {                                      # Boot Options
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];        # Video Drivers
  };

  
  # Allow unfree packages

  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  git
  htop
  nano
  lm_sensors
  home-manager
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

   # services
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    printing.enable = true;
    flatpak.enable = true;
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  
 #boot.kernelPackages = pkgs.linuxPackages_latest;
 #boot.initrd.kernelModules = [ "amdgpu" ]; # Video drivers
 services.xserver.videoDrivers = [ "amdgpu" ];
 hardware.enableRedistributableFirmware = true;



  # Enable the GNOME Desktop Environment.
   services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome.enable = true;

  #services.xserver.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #programs.hyprland.enable = true;

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
  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    home =  "/home/stephan";
    isNormalUser = true;
    description = "Stephan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
    
  };




  # List packages installed in system profile. To search, run:
  # $ nix search wget
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  #system.autoUpgrade = {
  #  enable = true;
  #  channel = "https://nixos.org/channels/nixos-unstable";
  # };
  
 

hardware.fancontrol.enable = true;

hardware.fancontrol.config = ''
# Configuration file generated by pwmconfig, changes will be lost
INTERVAL=10
DEVPATH=hwmon0=devices/pci0000:00/0000:00:02.3/0000:05:00.0
DEVNAME=hwmon0=amdgpu
FCTEMPS= hwmon0/pwm1=hwmon0/temp1_input
FCFANS= hwmon0/pwm1=hwmon0/fan1_input
MINTEMP= hwmon0/pwm1=45
MAXTEMP= hwmon0/pwm1=75
MINSTART= hwmon0/pwm1=150
MINSTOP= hwmon0/pwm1=0
MAXPWM= hwmon0/pwm1=255
'';

 programs.hyprland.enable = true;
 
environment.sessionVariables = {
  WLR_NO_HARDWARE_CURSORS = "1";
  NIXOS_OZONE_WL = "1";
};
 
 hardware = {
    opengl.enable = true;
};
 
 xdg.portal.wlr.enable = true;
 programs.hyprland.xwayland.enable = true;
 xdg.portal.enable = true;
 
 xdg.portal.config = {
  common = {
    default = [
      "gtk"
    ];
  };
 };
#home-manager.users.${user} = { pkgs, ... }: {
#home.stateVersion = "23.11";  
#programs.home-manager.enable = true;
#home.packages = [ pkgs.chromium pkgs.thunderbird ];
#programs.bash.enable = true;
#};

  
}

