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
      hide_scroll = true;
      hide_search = true;
      insensitive = true;
      lines = 10;
      no_actions = true;
      prompt = "";
      sort_order = "alphabetical";
    };
    style = ''
      * {
        font-family: "Hack Nerd Font", monospace;
        font-size: 14px;
      }
      #window, #outer-box {
        border-radius: 5px;
      }
      #outer-box {
        padding: 5px;
      }
      #outer-box, #inner-box, #input, #entry {
        background: #111111;
      }
      #entry:selected {
        background: #000000;
        outline: none;
      }
    '';
  };
}
