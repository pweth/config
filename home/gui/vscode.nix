/*
* Microsoft Visual Studio Code configuration.
*/

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Extensions
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      esbenp.prettier-vscode
      golang.go
      haskell.haskell
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      ms-python.python
      ms-toolsai.jupyter
      ms-vscode.hexeditor
      ms-vscode.makefile-tools
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      yzhang.markdown-all-in-one
    ];

    # settings.json values
    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "jupyter.askForKernelRestart" = false;
      "remote.downloadExtensionsLocally" = true;
      "remote.SSH.defaultExtensions" = [
        "jnoortheen.nix-ide"
      ];
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.fontFamily" = "Hack";
      "update.mode" = "none";
      "workbench.colorTheme" = "Default Dark Modern";
      "workbench.startupEditor" = "none";
    };
  };
}
