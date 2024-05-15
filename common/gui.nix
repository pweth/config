/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, user, ... }:

{
  # GUI setup
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    excludePackages = [ pkgs.xterm ];
    libinput.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    firefox
    gparted
    vscode
  ];

  # Exclude unwanted default Gnome packages
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
    gnome-calendar
    gnome-characters
    gnome-contacts
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    seahorse
    simple-scan
    totem
    yelp
  ]);

  # Home manager GUI packages
  home-manager.users."${user}" = import ../home/gui;

  # Mount localhost TLS key
  age.secrets.localhost-key = {
    file = ../secrets/localhost-key.age;
    mode = "644";
  };

  # HTTPS-over-DNS proxy for Firefox
  services.dnscrypt-proxy2.settings.local_doh = {
    cert_file = builtins.toString ../keys/certificates/localhost.crt;
    cert_key_file = config.age.secrets.localhost-key.path;
    listen_addresses = [ "127.0.0.1:44214" ];
    path = "/";
  };
}
