/*
* The Secure Shell protocol.
*/

{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      ChallengeResponseAuthentication = false;
      GSSAPIAuthentication = false;
      KerberosAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
}
