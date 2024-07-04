/*
* Common system configuration across all hosts.
*/

{ config, pkgs, agenix, domain, host, nixpkgs-unstable, user, ... }:

{
  imports = [
    ./acme.nix
    ./fonts.nix
    ./impermanence.nix
    ./locale.nix
    ./metrics.nix
    ./networking.nix
    ./nginx.nix
    ./security.nix
    ./tailscale.nix
    ./user.nix
  ];

  # NixOS release version
  system.stateVersion = "23.11";

  # Remove NixOS manual
  documentation.nixos.enable = false;

  # Environment variables
  environment.sessionVariables = {
    BAT_THEME = "TwoDark";
    EDITOR = "nvim";
    HISTCONTROL = "ignoreboth";
    HISTSIZE = "10000";
    HISTFILESIZE = "15000";
    HISTTIMEFORMAT = "%F %T ";
    MINICOM = "-con";
    TZ_LIST = builtins.concatStringsSep ";" [
      "America/New_York,New York"
      "Europe/London,London"
      "Asia/Kolkata,Hyderabad"
      "Australia/Sydney,Sydney"
    ];
  };

  # System packages
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ] ++ (with pkgs; [
    age
    age-plugin-yubikey
    bat
    curl
    diff-pdf
    dig
    duf
    eza
    file
    fzf
    gawk
    git
    htop
    inetutils
    jq
    killall
    neofetch
    neovim
    openssl
    p7zip
    rclone
    restic
    ripgrep
    tldr
    tmux
    tree
    tz
    unzip
    usbutils
    wget
    xclip
    zip
  ]);

  # Home manager
  home-manager = {
    extraSpecialArgs = {
      domain = domain;
      host = host;
      user = user;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = import ../home/cli;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatic `nix store optimise`
  nix.settings.auto-optimise-store = true;

  # Nix subcommands and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree and overlay unstable packages
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import nixpkgs-unstable {
          config.allowUnfree = true;
          system = prev.system;
        };
      })
    ];
  };

  # Fuzzy finder
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  # Java
  programs.java.enable = true;
}
