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
        color = "rgb(42, 101, 87)";
        path = "${../static/background.jpg}";
      }];
      input-field = [{
        check_color = "rgba(0, 0, 0, 0)";
        fail_color = "rgba(0, 0, 0, 0)";
        font_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0)";
        outer_color = "rgba(0, 0, 0, 0)";
        fail_text = "";
        placeholder_text = "";
      }];
      label = [{
        text = "$TIME";
        color = "rgb(255, 255, 255)";
        font_family = "Hack Nerd Font";
        font_size = 96;
        text_align = "center";
        halign = "center";
        valign = "center";
        position = "0, 160";
      }];
    };
  };
}
