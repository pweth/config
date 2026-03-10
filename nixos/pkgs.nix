{ pkgs, ... }:

{
  # NixOS-only packages
  environment.systemPackages = with pkgs; [
    bubblewrap
    coreutils
    ethtool
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
