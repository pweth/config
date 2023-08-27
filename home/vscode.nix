{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Extensions to install
    extensions = with pkgs.vscode-extensions; [
      attilabuti.brainfuck-syntax
      eamodio.gitlens
      esbenp.prettier-vscode
      golang.go
      grapecity.gc-excelviewer
      gruntfuggly.todo-tree
      haskell.haskell
      jnoortheen.nix-ide
      ms-python.python
      ms-vscode.cpptools
      ms-vscode.hexeditor
      ms-vscode.powershell
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      vscode-icons-team.vscode-icons
      yzhang.markdown-all-in-one
    ];

    # settings.json values
    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "explorer.confirmDelete" = false;
      "workbench.colorTheme" = "Default Dark Modern";
    };
  };
}
