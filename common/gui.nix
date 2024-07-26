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
      displayManager.lightdm.enable = true;
      excludePackages = [ pkgs.xterm ];
      windowManager.dwm.enable = true;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    dmenu
    emote
    firefox
    gnome.gnome-keyring
    gparted
    st
    vscode
  ];

  # Home manager GUI packages
  home-manager.users."${user}" = import ../home/gui;

  # Override dwm source
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = /etc/nixos/dwm;
      });
    })
  ];
}
