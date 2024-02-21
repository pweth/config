/*
* Cowyodel Go module derivation.
*/

{ config, lib, pkgs, ... }:
let
  cowyodel = pkgs.buildGoModule {
    name = "cowyodel";

    src = pkgs.fetchFromGitHub {
      owner = "schollz";
      repo = "cowyodel";
      rev = "ffbc159859ace5207f475475108fcd0f557a219b";
      hash = "sha256-wJTMcXrv0/C+keFy2gCkNu5jX2CoEw2Dk5Ja0SI1BRA=";
    };

    vendorHash = "sha256-jn3vum9ogUqgmT5Db7mFt9RNDZ9cMoCXZNswHwQDpAE=";
    doCheck = false;

    meta = {
      description = "Easily move things between computers using cowyo";
      homepage = "https://github.com/schollz/cowyodel";
      license = lib.licenses.mit;
    };
  };
in
{
  home.packages = [
    cowyodel
  ];
}
