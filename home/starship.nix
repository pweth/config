/*
  * Starship cross-shell prompt configuration.
  * https://starship.rs/
*/

{ config, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
      character = {
        error_symbol = "[;](bold red)";
        success_symbol = "[: ;](bold green)";
      };
      cmd_duration = {
        min_time = 5000;
        style = "bold";
      };
      hostname = {
        disabled = false;
        ssh_only = false;
        ssh_symbol = "";
        style = "bold green";
      };
      package.disabled = true;
      status = {
        disabled = false;
        format = "[: $status]($style) ";
      };
      username = {
        disabled = false;
        format = "[$user]($style) → ";
        show_always = true;
      };
    };
  };
}
