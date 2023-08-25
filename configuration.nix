{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports = [
    # Import hardware scan file
    ./hardware-configuration.nix
    # Import home manager
    (import "${home-manager}/nixos")
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
    # Set hostname to 'chordata'
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
    gnome-music
    gedit
    epiphany
    geary
    evince
    gnome-characters
    tali
    iagno
    hitori
    atomix
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

  # Home manager
  home-manager.users.pweth = { pkgs, ... }: {
    home.stateVersion = "18.09";

    # Firefox
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          search.default = "DuckDuckGo";
          search.engines = {
            "Amazon.co.uk".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
          search.force = true;
          settings = {
            # Change Enhanced Tracking Protection to strict
            "browser.contentblocking.category" = "strict"; 
            # Disable new tab page
            "browser.newtab.url" = "about:blank";
            "browser.newtabpage.activity-stream.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.newtabpage.enabled" = false;
            "browser.ping-centre.telemetry" = false;
            # Set search region to UK
            "browser.search.region" = "GB";
            "browser.search.isUS" = false;
            # Set home page
            "browser.startup.homepage" = "https://start.duckduckgo.com";
            # Clean up the URL bar
            "browser.urlbar.shortcuts.bookmarks" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.urlbar.showSearchSuggestionsFirst" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.suggest.searches" = false;
            # Disable health reports
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            # Dev tools theme
            "devtools.theme" = "dark";
            # Disable battery API
            "dom.battery.enabled" = false;
            # Disable gamepad API
            "dom.gamepad.enabled" = false;
            # Disable experiments
            "experimens.activeExperiment" = false;
            "experiments.enabled" = false;
            "experiments.manifest.uri" = "";
            "experiments.supported" = false;
            "network.allow-experiments" = false;
            # Disable pocket
            "extensions.pocket.enabled" = false;
            # Privacy settings
            "privacy.donottrackheader.enabled" = true;
            "privacy.donottrackheader.value" = 1;
            "privacy.purge_trackers.enable" = true;
            # Disable the built-in password manager
            "signon.rememberSignons" = false;
            # Disable telemetry
            "toolkit.coverage.endpoint.base" = "";
            "toolkit.coverage.opt-out" = true;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.eabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
          };
        };
      };
    };

    # Git
    programs.git = {
      enable = true;
      userName = "pweth";
      userEmail = "22416843+pweth@users.noreply.github.com";
      # Use the difftastic syntax highlighter
      difftastic.enable = true;
      difftastic.color = "always";
    };

    # Gnome dconf settings
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/pweth/dotfiles/img/background.jpg";
          picture-uri-dark = "file:///home/pweth/dotfiles/img/background.jpg";
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          show-battery-percentage = true;
          text-scaling-factor = 1.3;
        };
        "org/gnome/desktop/notifications" = {
          show-in-lock-screen = false;
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
        };
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
        };
      };
    };
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
