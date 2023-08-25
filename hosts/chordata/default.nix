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
      # Enable the new `nix` subcommands and flakes
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

  # Set console keyboard map to UK format
  console.keyMap = "uk";

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
  
  # GUI
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    layout = "gb";
    libinput.enable = true;
    xkbVariant = "";
  };

  # Exclude unwanted default Gnome packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    atomix
    epiphany
    evince
    geary
    gedit
    gnome-characters
    gnome-music
    hitori
    iagno
    tali
  ]);

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    bitwarden
    cmatrix
    cowsay
    curl
    dig
    duf
    exiftool
    ffmpeg
    firefox
    gcc
    gh
    gimp
    git
    go
    htop
    libreoffice
    lolcat
    micro
    neofetch
    nms
    nodejs
    openssl
    (python3.withPackages (ps: with ps; [
      ipython
      jupyter
      matplotlib
      numpy
      pandas
      setuptools
    ]))
    rustup
    sl
    spotify
    tldr
    tree
    vim
    vscode
    wget
  ];

  # NixOS release version
  system.stateVersion = "23.05";
}
