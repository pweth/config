/*
  * Wofi configuration.
  * https://hg.sr.ht/~scoopta/wofi
*/

{ config, ... }:
let
  height = "48px";
in
{
  programs.wofi = {
    enable = true;
    settings = {
      gtk_dark = true;
      height = height;
      hide_scroll = true;
      insensitive = true;
      location = "top";
      mode = "dmenu";
      no_actions = true;
      orientation = "horizontal";
      prompt = "";
      width = "160%";
      yoffset = "-${height}";
    };
    style = builtins.readFile ../static/styles/wofi.css;
  };
}
