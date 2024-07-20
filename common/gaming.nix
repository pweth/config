/*
* Gaming configuration.
*/

{ config, lib, pkgs, host, user, ... }:

{
  # Game packages
  environment.systemPackages = with pkgs; [
    prismlauncher
    wineWowPackages.stable
  ];

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Steam
  programs.steam.enable = true;

  # Persist game data
  environment.persistence = lib.mkIf host.impermanent { 
    "/persist".users."${user}".directories = [
      ".local/share/PrismLauncher"
      ".local/share/Steam"
      ".steam"
    ];
  };
}
