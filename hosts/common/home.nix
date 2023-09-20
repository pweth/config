/*
* Common ome manager configuration across all enabled hosts.
*/

{ config, pkgs, home-manager, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.pweth = import ../../home;
}
