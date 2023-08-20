{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix          # Import hardware scan file
  ];

  nix = {
    gc = {
      automatic = true;                   # Enable automatic garbage collection
      dates = "weekly";                   # Schedule once a week
      options = "--delete-older-than 7d"; # Target store entries older than 7 days
    };
    settings = {
      auto-optimise-store = true;         # Automatic `nix store --optimise`
      experimental-features = [
        "nix-command"                     # Enable the new `nix` subcommands
        "flakes"                          # Enable flakes
      ];
    };
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "chordata";                # Set hostname to 'chordata'
    networkmanager.enable = true;         # Enable networking
  };

  services.printing.enable = true;        # Enable CUPS to print documents

  nixpkgs.config.allowUnfree = true;      # Allow unfree packages

  console.keyMap = "uk";                  # Set console keyboard map to UK format
  time.timeZone = "Europe/London";        # Set timezone to London
  i18n.defaultLocale = "en_GB.UTF-8";     # Configure UK locale settings
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
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    layout = "gb";
    libinput.enable = true;
    xkbVariant = "";
  };

  sound.enable = true;                    # Enable sound with pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.peter = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      cmatrix
      cowsay
      firefox
      gh
      git
      go
      htop
      lolcat
      micro
      neofetch
      nms
      nodejs
      rustup
      sl
      tree
      vscode
    ];
  };

  environment.systemPackages = with pkgs; [
    curl
    dig
    vim
    wget
  ];

  system.stateVersion = "23.05";

}
