{ pkgs, ... }:

{
  # ssh-agent launchd service
  launchd.user.agents.ssh-agent = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.openssh}/bin/ssh-agent"
        "-a"
        "/Users/pweth/.ssh/ssh-agent.sock"
        "-D"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  # Override the macOS authentication socket
  environment.variables.SSH_AUTH_SOCK="/Users/pweth/.ssh/ssh-agent.sock";
}
