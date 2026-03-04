{ inputs, pkgs, ... }:

{
  imports = [
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    ./homebrew.nix
    ./settings.nix
    ./wallpaper.nix
  ];

  # SSH configuration
  environment.etc."ssh/ssh_config.d/100-hardware-agents.conf".text = ''
    Host *
      # macOS Secure Enclave (Touch ID)
      IdentityAgent /Users/pweth/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

      # YubiKeys
      IdentityFile /Users/pweth/.ssh/igneous
      IdentityFile /Users/pweth/.ssh/sedimentary
  '';

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
