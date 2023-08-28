{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Underline";
        unfocused_hollow = false;
      };
      font = {
        size = 14;
      };
      key_bindings = [
        {
          key = "N";
          mods = "Control";
          action = "CreateNewWindow";
        }
        {
          key = "W";
          mods = "Control";
          action = "Quit";
        }
      ];
    };
  };
}
