{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Set username and user email
    userName = "pweth";
    userEmail = "22416843+pweth@users.noreply.github.com";

    # Use the difftastic syntax highlighter
    difftastic = {
      enable = true;
      color = "always";
    };

    # Additional configuration
    extraConfig = {
      core = {
        editor = "micro";
      };
      credential = {
        helper = "store";

        # Manually ensure the correct gh package
        "https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
        "https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credentials";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
