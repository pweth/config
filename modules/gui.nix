# * GUI module.

{
  config,
  lib,
  pkgs,
  nixpkgs-citrix,
  ...
}:
let
  cfg = config.modules.gui;
in
{
  options.modules.gui.enable = lib.mkEnableOption "GUI";

  config = lib.mkIf cfg.enable {
    # GUI setup
    services = {
      displayManager.autoLogin = {
        enable = true;
        user = "pweth";
      };
      libinput.enable = true;
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    services.hypridle.enable = true;

    # GUI system packages
    environment.systemPackages = with pkgs; [
      discord
      eog
      firefox
      handbrake
      hyprlock
      hyprpaper
      hyprshot
      kitty
      libreoffice
      nautilus
      obs-studio
      pinta
      prismlauncher
      spotify
      sqlitebrowser
      vlc
      vscode
      wireshark
      wl-clipboard
      wofi
      wofi-emoji
      zoom-us
    ];

    # Wayland environment variables
    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";

      # Cursor theme
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";

      # NVIDIA-specific
      GBM_BACKEND = "nvidia-drm";
      LIBGL_ALWAYS_SOFTWARE = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      "__GL_THREADED_OPTIMIZATIONS" = "0";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    };

    # OpenGL
    hardware.graphics.enable = true;

    # Home manager GUI packages
    home-manager = {
      extraSpecialArgs = { inherit nixpkgs-citrix; };
      users.pweth = import ../gui;
    };

    # Desktop wallpaper service
    systemd.services.wallpaper = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.curl}/bin/curl -L -o /var/lib/wallpaper.jpg https://pweth.com/noindex/img/background.jpg";
        ExecPost = "${pkgs.coreutils}/bin/chmod 644 /var/lib/wallpaper.jpg";
      };
    };
  };
}
