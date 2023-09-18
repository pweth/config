{ config, pkgs, ... }:

{
  home = {
    packages = [ pkgs.tz ];
    sessionVariables.TZ_LIST = "America/New_York;Europe/London;Australia/Sydney";
  };
}
