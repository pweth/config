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
        immediate_render = true;
        no_fade_in = true;
        no_fade_out = true;
      };
      background = [{
        blur_passes = 2;
        path = "${../static/background.jpg}";
      }];
      input-field = [{
        check_color = "rgba(0, 0, 0, 0)";
        dots_fade_time = 0;
        fade_timeout = 0;
        fail_color = "rgba(0, 0, 0, 0)";
        fail_timeout = 0;
        fail_transition = 0;
        font_color = "rgba(255, 255, 255, 0.5)";
        inner_color = "rgba(0, 0, 0, 0)";
        outer_color = "rgba(0, 0, 0, 0)";
        fail_text = "";
        placeholder_text = "";
      }];
      label = [{
        text = "󰜗 $TIME";
        color = "rgb(255, 255, 255)";
        font_family = "Hack Nerd Font";
        font_size = 96;
        halign = "center";
        position = "0, 160";
        text_align = "center";
        valign = "center";
      }];
    };
  };
}
