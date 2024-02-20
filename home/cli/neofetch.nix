/*
* Neofetch configuration.
*/

{ config, host, ... }:

{
  xdg.configFile."neofetch/config.conf".text = ''
    print_info () {
      info title
      info underline
      prin "Species" "${host.species}"
      info "Host" model
      info "OS" distro
      info "Kernel" kernel
      info "Uptime" uptime
      info "Packages" packages
      info "Shell" shell
      info "Resolution" resolution
      info "DE" de
      info "WM" wm
      info "Terminal" term
      info "CPU" cpu
      info "GPU" gpu
      info "Memory" memory
      info "Disk" disk
      info cols
    }
  '';
}
