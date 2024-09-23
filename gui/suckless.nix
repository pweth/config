/*
* Suckless configuration.
*/

{ config, pkgs, ... }:

{
  # Substitute into the config.def.h files
  environment.systemPackages = with pkgs; (builtins.map (
    program: (program.package.overrideAttrs (old: {
      postPatch = builtins.concatStringsSep "\n" ([ old.postPatch ] ++ (builtins.map (
        change: "${gnused}/bin/sed -i \"s/${change}/g\" config.def.h"
      ) program.changes));
    }))
  ) [
    { package = dmenu; changes = [ "monospace:size=10/Hack:size=13" "#005577/#111111" ]; }
    { package = st; changes = [ "Liberation Mono:pixelsize=12/Hack:size=13" "cursorshape = 2/cursorshape = 6" ]; }
  ]);

  # Overlay for dwm package
  nixpkgs.overlays = with pkgs; [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: rec {
        # Install patches
        patches = [
          ../static/patches/alwayscenter.diff
          ../static/patches/splitstatus.diff
        ];

        # Override config.def.h file
        configFile = writeText "config.def.h" (builtins.readFile ../static/dwm.config.h);
        postPatch = "${old.postPatch}\ncp ${configFile} config.def.h";
      });
    })
  ];

  # Lock screen
  programs.slock.enable = true;
}
