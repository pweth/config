/*
* Python configuration.
*/

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      aiohttp
      arrow
      jupyter
      matplotlib
      nltk
      notebook
      numpy
      opencv4
      pandas
      pip
      pydantic
      pygments
      pyjwt
      pytest
      pyzmq
      requests
      rich
      scikit-learn
      setuptools
      virtualenv
    ]))
  ];
}
