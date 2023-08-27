<div align="center">
	<h1>⚙️ NixOS Configuration Flake</h1>
	<img width="400" src="https://github.com/pweth/dotfiles/assets/22416843/224c3d32-5806-491f-9490-3220d7b28caa">
</div>

---

## Usage

After installing NixOS, enter a shell with git installed:

```
nix --extra-experimental-features nix-command \
  --extra-experimental-features flakes        \
  shell nixpkgs#git
```

Clone this repository:

```
git clone https://github.com/pweth/dotfiles
cd dotfiles
```

Update the hardware configuration (if required):

```
cp -f /etc/nixos/hardware-configuration.nix   \
  ./hosts/chordata/hardware-configuration.nix
```

Build the system:

```
sudo nixos-rebuild switch --flake .#chordata
```

---

## To-Do

- Fix keymaps to add Dvorak to xkb
- Add .face using home manager
