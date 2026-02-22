{ inputs, pkgs, ... }:

{
  # NixOS-only packages
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages."${system}".default
    bubblewrap
    coreutils
    inetutils
    ncdu
    nethogs
    networkmanager
    pciutils
    strace
    usbutils
    valgrind
    xclip
  ];
}
