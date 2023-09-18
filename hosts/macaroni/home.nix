{ config, pkgs, ... }:

{
  imports = [
    ../../packages/bash.nix
    ../../packages/git.nix
    ../../packages/starship.nix
    ../../packages/tz.nix
  ];
}
