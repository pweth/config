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
        size = 11;
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
      window = {
        dynamic_title = false;
        title = "Terminal";
      };
    };
  };
}
