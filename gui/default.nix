/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, user, ... }:

{
  imports = [
    ./suckless.nix
  ];

  # GUI setup
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = user;
    };
    libinput.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        sessionCommands = ''
          ${pkgs.feh}/bin/feh --bg-scale $(cat /home/${user}/.wallpaper)
        '';
      };
      dpi = 120;
      excludePackages = [ pkgs.xterm ];
      windowManager.dwm.enable = true;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    emote
    feh
    firefox
    flameshot
    gparted
    playerctl
    vscode
  ];

  # Home manager GUI packages
  home-manager.users."${user}" = import ./home.nix;

  # Emote and status bar daemons
  systemd.user.services = {
    emote = {
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = "${pkgs.emote}/bin/emote";
      wantedBy = [ "graphical-session.target" ];
    };
    status-bar = {
      partOf = [ "graphical-session.target" ];
      path = with pkgs; [
        gawk
        jq
        networkmanager
        playerctl
        tailscale
        xorg.xsetroot
      ];
      script = "exec ${../static/scripts/status-bar.sh}";
      wantedBy = [ "graphical-session.target" ];
    };
  };
}
