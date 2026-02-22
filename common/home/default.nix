{ ... }:

{
  imports = [
    ./git.nix
    ./shells.nix
    ./starship.nix
    ./tmux.nix
  ];

  home = {
    stateVersion = "24.11";
    username = "pweth";
  };
}
