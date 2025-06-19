/*
  * Home manager configuration for GUI programs.
  * See ../home for CLI programs.
*/

{
  config,
  pkgs,
  ...
}:

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
    discord
    eog
    handbrake
    libreoffice
    obs-studio
    pinta
    prismlauncher
    qFlipper
    shotcut
    spotify
    sqlitebrowser
    vlc
    wireshark
    zoom-us

    # Anki Wayland display bug
    (writeShellScriptBin "anki" ''
      QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu" exec ${pkgs.anki}/bin/anki "$@"
    '')

    # Prevent Citrix Workspace segfault
    (writeShellScriptBin "wfica" ''
      env -i DISPLAY=:0 ${pkgs.citrix_workspace}/bin/wfica "$@"
    '')
  ];

  # Citrix EULA
  home.file.".ICAClient/.eula_accepted".text = "yes";

  # GTK bookmarks and dark theme
  xdg.configFile = {
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
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    music = null;
    publicShare = null;
    templates = null;
    videos = null;
  };
}
