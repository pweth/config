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
      width = "2570px";
      yoffset = "-41px";
    };
    style = ''
      * {
        font-family: "Hack Nerd Font", monospace;
        font-size: 16px;
      }
      #window, #outer-box {
        border-radius: 0;
      }
      #outer-box, #inner-box, #input, #entry {
        background: #111111;
        text-align: left;
      }
      #input, #input:focus {
        border: none;
        box-shadow: none;
        outline: none;
      }
      #entry, #entry:selected {
        border: none;
        border-top: solid 2px #111111;
        outline: none;
        padding: 10px 15px;
        width: fit-content;
      }
      #entry:selected {
        background: #000000;
        border-color: #ffffff;
      }
    '';
  };
}
