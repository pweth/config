{ inputs, pkgs, ... }:

{
  imports = [
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    ./homebrew.nix
    ./settings.nix
    ./ssh-agent.nix
    ./wallpaper.nix
  ];

  # Nix settings
  nix.enable = false;

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Set Git commit hash for darwin-version
  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;

  # User account
  system.primaryUser = "pweth";
  users.users.pweth = {
    name = "pweth";
    home = "/Users/pweth";
  };

  # Original release version
  system.stateVersion = 6;
}
