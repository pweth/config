/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, user, ... }:

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
      dpi = 110;
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    firefox
    gparted
    hyprshot
    kitty
    playerctl
    swww
    vscode
    waybar
    wl-clipboard
    wofi
    wofi-emoji
  ];

  # Home manager GUI packages
  home-manager.users."${user}" = import ./home.nix;
}
