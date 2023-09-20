/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "matosama/cowyo";
    ports = [ "8050:8050" ];
    volumes = [
      "/home/pweth/cowyo:/data"
    ];
  };
}
