/*
  * Home manager configuration for GUI programs.
  * See ../home for CLI programs.
*/

{
  config,
  pkgs,
  nixpkgs-citrix,
  ...
}:
let
  citrixPkgs = import nixpkgs-citrix {
    localSystem = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./vscode.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    # Anki Wayland display bug
    (writeShellScriptBin "anki" ''
      QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu" exec ${pkgs.anki}/bin/anki "$@"
    '')

    # Prevent Citrix Workspace segfault
    (writeShellScriptBin "wfica" ''
      env -i DISPLAY=:0 ${citrixPkgs.citrix_workspace}/bin/wfica "$@"
    '')
  ];

  # Citrix EULA
  home.file.".ICAClient/.eula_accepted".text = "yes";

  dconf.settings = {
    # GNOME application dark theme
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    # virt-manager auto-connect
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  xdg = {
    # XDG portals for screen sharing and file picking
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common.default = ["gtk"];
        hyprland.default = ["hyprland" "gtk"];
      };
    };

    # GTK bookmarks and dark theme
    configFile = {
      "gtk-3.0/bookmarks".text = ''
        file:///etc/nixos/config
        file:///persist
        file:///home/pweth/Documents
        file:///home/pweth/Downloads
        file:///home/pweth/Pictures
      '';
      "gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=1
      '';
    };

    # User base directories
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
      videos = null;
    };
  };
}
