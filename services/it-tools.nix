/*
* Useful tools for developer and people working in IT.
* https://github.com/CorentinTh/it-tools
*/

{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.it-tools = {
    autoStart = true;
    image = "ghcr.io/corentinth/it-tools:latest";
    ports = [ "47635:80" ];
  };
}
