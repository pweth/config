<div align="center">
	<h1>⚙️ NixOS Configuration Flake</h1>
</div>

---

## Installation

- Install a fresh version of NixOS
- Enter a shell with `git` installed
  - `nix --extra-experimental-features nix-command --extra-experimental-features flakes shell nixpkgs#git`
- Clone this repository
  - `git clone https://github.com/pweth/dotfiles && cd dotfiles`
- Update the hardware configuration (if required)
  - `cp -f /etc/nixos/hardware-configuration.nix ./hosts/chordata/hardware-configuration.nix`
- Re-build the system
  - `sudo nixos-rebuild switch --flake .#chordata`

---

## To-Do

- Fix keymaps to add Dvorak to xkb
- Add .face using home manager
