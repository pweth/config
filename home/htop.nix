# * htop configuration.

{ config, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      color_scheme = 6;
      enable_mouse = 1;
      show_program_path = 0;
      show_thread_names = 0;
      tree_view = 1;
    };
  };
}
