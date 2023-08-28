<div align="center">
	<h1>⚙️ NixOS Configuration</h1>
	<img width="400" src="https://github.com/pweth/dotfiles/assets/22416843/bf22ddd3-bfb0-47a1-bd60-b46be7568bbd">
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
