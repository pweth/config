# * Common system configuration across all hosts with a GUI.

{
  config,
  pkgs,
  home-manager,
  user,
  ...
}:

{
  # GUI setup
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = user;
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
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    alsa-utils
    brightnessctl
    firefox
    gparted
    hyprpaper
    hyprshot
    kitty
    networkmanagerapplet
    pcmanfm
    playerctl
    vscode
    wev
    wl-clipboard
    wofi
    wofi-emoji
  ];

  # Ozone Wayland support in Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Home manager GUI packages
  home-manager.users."${user}" = import ./home.nix;
}
