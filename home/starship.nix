/*
* Starship cross-shell prompt configuration.
* https://starship.rs/
*/

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
      cmd_duration = {
        min_time = 5000;
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
