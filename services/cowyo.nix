/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "matosama/cowyo";
    ports = [ "44615:8050" ];
  };
}
