/*
* Jupyter Notebook server.
* https://jupyter.org
*/

{ config, pkgs, ... }:

{
  services.jupyter = {
    enable = true;
    port = 43067;
  };
}
