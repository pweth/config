/*
* Emoji picker configuration.
* https://github.com/tom-james-watson/emote
*/

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    emote
  ];

  # User daemon
  systemd.user.services.emote = {
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.emote}/bin/emote";
      Restart = "always";
    };
  };
}
