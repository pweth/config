/*
* Jupyter Notebook server.
* https://jupyter.org
*/

{ config, pkgs, ... }:
let
  kernel = pkgs.python3.withPackages (ps: with ps; [
    build
    gensim
    ipython
    jupyter
    matplotlib
    nltk
    numpy
    pandas
    pip
    rich
    scikit-learn
    setuptools
    spacy
  ]);
in
{
  age.secrets.jupyter = {
    file = ../secrets/jupyter.age;
    owner = "jupyter";
  };

  services.jupyter = {
    enable = true;
    ip = "0.0.0.0";
    password = "open('${config.age.secrets.jupyter.path}', 'r', encoding='utf8').read().strip()";
    port = 43067;
  };

  services.jupyter.kernels.python3 = {
    argv = [ "${kernel.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
    displayName = "Python ${pkgs.python3.version}";
    language = "python";
  };

  users = {
    groups.jupyter = {};
    users.jupyter.group = "jupyter";
  };
}
