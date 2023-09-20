/*
* Container services to run on the VPS.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./cowyo.nix
    ./uptime-kuma.nix
  ];
}
