/*
  * Hyprlock configuration.
  * https://github.com/hyprwm/hyprlock
*/

{ config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        immediate_render = true;
        no_fade_in = true;
        no_fade_out = true;
      };
      background = [
        {
          color = "rgb(0, 0, 0)";
        }
      ];
      input-field = [
        {
          check_color = "rgb(0, 0, 0)";
          dots_fade_time = 0;
          dots_size = "0.5";
          dots_text_format = "*";
          fade_timeout = 0;
          fail_color = "rgb(0, 0, 0)";
          fail_timeout = 0;
          fail_transition = 0;
          font_color = "rgba(255, 255, 255, 0.75)";
          inner_color = "rgb(0, 0, 0)";
          outer_color = "rgb(0, 0, 0)";
          fail_text = "";
          placeholder_text = "";
        }
      ];
      label = [
        {
          text = "$TIME";
          font_family = "FiraCode Nerd Font";
          font_size = 96;
          position = "0, 160";
        }
      ];
    };
  };
}
