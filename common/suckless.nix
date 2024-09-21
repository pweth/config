/*
* Suckless configuration.
*/

{ config, pkgs, ... }:

{
  # Substitute into the config.def.h files
  environment.systemPackages = with pkgs; builtins.map (
    program: (program.package.overrideAttrs (old: {
      postPatch = builtins.concatStringsSep "\n" ([ old.postPatch ] ++ (builtins.map (
        change: "${gnused}/bin/sed -i \"s/${change}/g\" config.def.h"
      ) program.changes));
    }))
  ) [
    { package = dmenu; changes = [ "monospace:size=10/Hack:size=13" "#005577/#111111" ]; }
    { package = st; changes = [ "Liberation Mono:pixelsize=12/Hack:size=13" "cursorshape = 2/cursorshape = 6" ]; }
  ];

  # Override dwm package source
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = /etc/nixos/dwm;
      });
    })
  ];

  # Lock screen
  programs.slock.enable = true;
}
