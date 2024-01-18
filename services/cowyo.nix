/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, host, ... }:

{
  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "matosama/cowyo";
    ports = [ "${builtins.toString host.entrypoints.cowyo.port}:8050" ];
    volumes = [
      "/home/pweth/cowyo:/data"
    ];
  };
}
