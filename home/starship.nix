{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
      cmd_duration = {
        min_time = 5000;
        min_time_to_notify = 30000;
        show_notifications = true;
        style = "bold";
      };
      hostname = {
        disabled = false;
        ssh_only = false;
        style = "bold green";
      };
      package.disabled = true;
      status.disabled = false;
      username = {
        disabled = false;
        format = "[$user]($style) → ";
        show_always = true;
      };
    };
  };
}
