/*
* Wofi configuration.
* https://hg.sr.ht/~scoopta/wofi
*/

{ config, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      gtk_dark = true;
      height = "40px";
      hide_scroll = true;
      insensitive = true;
      location = "top";
      mode = "dmenu";
      no_actions = true;
      orientation = "horizontal";
      prompt = "";
      width = "160%";
      yoffset = "-41px";
    };
    style = builtins.readFile ../static/styles/wofi.css;
  };
}
