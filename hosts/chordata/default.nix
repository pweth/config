{ config, pkgs, home-manager, agenix, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Automatic `nix store optimise`
    settings.auto-optimise-store = true;

    # Enable `nix` subcommands and flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
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

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  services.xserver = {
    # GUI
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    enable = true;
    excludePackages = [ pkgs.xterm ];
    libinput.enable = true;

    # UK QWERTY and Dvorak layouts (TODO)
    layout = "gb,gb";
    xkbVariant = ",dvorakukp";
    xkbOptions = "grp:win_space_toggle";
  };

  # Use X keyboard in the console
  console.useXkbConfig = true;

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Load in all agenix secrets
  age.identityPaths = [ "/home/pweth/.ssh/id_ed25519" ];
  age.secrets.duckduckgo-api-key.file = ../../secrets/duckduckgo-api-key.age;
  age.secrets.internetas.file = ../../secrets/internetas.age;
  age.secrets.password-hash.file = ../../secrets/password-hash.age;

  # Set hostname and enable network manager
  networking = {
    hostName = "chordata";
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
    networkmanager.enable = true;
  };

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    passwordFile = config.age.secrets.password-hash.path;
  };

  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.pweth = import ../../home;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    agenix.packages.x86_64-linux.default
    curl
    dig
    git
    gnupg
    htop
    tree
    vim
    wget
  ];

  # System services
  services.keybase.enable = true;
  services.printing.enable = true;

  # Enable ClamAV daemon and automatic `freshclam`
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # NextDNS proxy (DNS-over-HTTPS)
  services.nextdns = {
    enable = true;
    arguments = [ "-profile" "ffa426" ];
  };

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
    gnome-weather
    seahorse
    simple-scan
    totem
    yelp
  ]);

  # NixOS release version
  system.stateVersion = "23.05";
}
