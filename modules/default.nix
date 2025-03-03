# * Module configuration.

{ config, ...}:

{
  imports = [
    ./gui.nix
    ./home-manager.nix
    ./impermanence.nix
  ];
}
