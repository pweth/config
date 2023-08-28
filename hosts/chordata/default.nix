{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    gc = {
      # Enable automatic garbage collection
      automatic = true;
      # Schedule once a week                 
      dates = "weekly";
      # Target store entries older than 7 days
      options = "--delete-older-than 7d";
    };
    settings = {
      # Automatic `nix store optimise`
      auto-optimise-store = true;
      # Enable `nix` subcommands and flakes
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    # Set hostname
    hostName = "chordata";

    # Enable network manager
    networkmanager.enable = true;
  };

  # Set time zone to London
  time.timeZone = "Europe/London";

  # Configure UK locale settings
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver = {
    # GUI
    enable = true;
    libinput.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    excludePackages = with pkgs; [
      xterm
    ];

    # UK QWERTY and Dvorak layouts
    # TODO
    layout = "gb,gb";
    xkbVariant = ",dvorakukp";
    xkbOptions = "grp:win_space_toggle";
  };
  console.useXkbConfig = true;

  # Exclude default Gnome packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-connections
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    baobab
    epiphany
    evince
    file-roller
    geary
    gedit
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-terminal
    seahorse
    simple-scan
    totem
    yelp
  ]);

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Printing
  services.printing.enable = true;

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    curl
    dig
    git
    tree
    vim
    wget
  ];

  # NixOS release version
  system.stateVersion = "23.05";
}
