# * Microsoft Visual Studio Code configuration.

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Extensions
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      golang.go
      haskell.haskell
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      ms-python.python
      ms-toolsai.jupyter
      ms-vscode.cpptools-extension-pack
      ms-vscode.hexeditor
      ms-vscode.makefile-tools
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      yzhang.markdown-all-in-one
    ];

    # settings.json values
    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "jupyter.askForKernelRestart" = false;
      "nix.formatterPath" = "nixfmt";
      "remote.downloadExtensionsLocally" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontLigatures" = true;
      "update.mode" = "none";
      "window.zoomLevel" = 0.9;
      "workbench.colorTheme" = "Default Dark Modern";
      "workbench.startupEditor" = "none";
    };
  };
}
