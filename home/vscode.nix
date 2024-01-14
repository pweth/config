/*
* Microsoft Visual Studio Code configuration.
*/

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Extensions to install
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      esbenp.prettier-vscode
      golang.go
      gruntfuggly.todo-tree
      haskell.haskell
      jnoortheen.nix-ide
      ms-python.python
      ms-vscode.cpptools
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
      "remote.downloadExtensionsLocally" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.fontFamily" = "Hack";
      "update.mode" = "none";
      "workbench.colorTheme" = "Default Dark Modern";
      "workbench.startupEditor" = "none";
    };
  };
}
