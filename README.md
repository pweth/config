<div align="center">
<h1>🐧 Config</h1>
NixOS configuration flake for my homelab.
<br/>
<br/>
<img src="./static/meme.png" width="448"/>
</div>

---

## Highlights

- 🖥️ Minimal and performant [Hyprland](https://github.com/pweth/config/blob/main/gui/hyprland.nix), [Waybar](https://github.com/pweth/config/blob/main/gui/waybar.nix) and [wofi](https://github.com/pweth/config/blob/main/gui/wofi.nix) configurations
- 💾 Declarative tmpfs root filesystems and LUKS encrypted Btrfs disks using [Disko](https://github.com/pweth/config/blob/main/modules/disko.nix) and [Impermanence](https://github.com/pweth/config/blob/main/modules/impermanence.nix)
- 🚫 [Blocky DNS-over-HTTPS resolver](https://github.com/pweth/config/blob/main/common/networking.nix) with integrated ad blocking and white-labeled Tailscale MagicDNS
- 🦊 Optimised Firefox browser featuring [personalised search engines](https://github.com/pweth/config/blob/main/gui/firefox.nix) and a [decluttered UI](https://github.com/pweth/config/blob/main/static/styles/firefox.css)
- 🎻 NixOS container (systemd-nspawn) [service encapsulation](https://github.com/pweth/config/blob/main/modules/services.nix) providing mount and network isolation
- 🔒 [agenix secret management](https://github.com/pweth/config/blob/main/secrets/secrets.nix) and YubiKey FIDO2-based [SSH authentication](https://github.com/pweth/config/blob/main/common/security.nix)
- 🌍 Fully automated remote [installation script](https://github.com/pweth/config/blob/main/install.sh) using nixos-anywhere

---

## Hosts

| Hostname | System |
| --- | --- |
| Adelie | Dell Precision 3280 |
| Humboldt | Dell OptiPlex 3050 Micro |
| Macaroni | Dell OptiPlex 3050 Micro |

---

## Flake Structure

```bash
.
├── common   # Config shared by all hosts
├── gui      # Home Manager GUI config
├── home     # Home Manager CLI config
├── hosts    # Host-specific config
├── modules  # Custom Nix modules
├── secrets  # age-encrypted secrets
├── services # Containerised apps running on the servers
└── static   # Static resources (CSS, images)
...
 ├── README.md  # You are here!
 ├── census.nix # Source of truth for metadata
 ├── flake.lock # Lock file
 ├── flake.nix  # Flake entry point
 └── install.sh # nixos-anywhere installation script
```

---

## Resources

- [How to Install NixOS on Oracle ARM machine](https://blog.digitalimmigrants.org/deploy-nixos-on-oracle-arm-machines/)
- [Betterfox User Preferences](https://github.com/yokoffing/Betterfox)
- [Declarative Docker Container Service in NixOS](https://www.breakds.org/post/declarative-docker-in-nixos/)
- [NixOS on ARM/Raspberry Pi](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi)
- [Tracking SQLite Database Changes in Git](https://garrit.xyz/posts/2023-11-01-tracking-sqlite-database-changes-in-git)
- [Firefox Web Apps by TLATER](https://github.com/TLATER/dotfiles/blob/master/home-modules/firefox-webapp.nix)
- [Using custom package in a NixOS module ](https://mdleom.com/blog/2021/07/02/custom-package-nixos-module/)
- [Encypted Btrfs Root with Opt-in State on NixOS](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html)
- [NixOS as a server, part 1: Impermanence](https://guekka.github.io/nixos-server-1/)
- [[RFC 0166] Nix formatting](https://github.com/NixOS/rfcs/pull/166)
- [Declarative Container Specification](https://nlewo.github.io/nixos-manual-sphinx/administration/declarative-containers.xml.html)
- [How I Set up BTRFS and LUKS on NixOS Using Disko](https://haseebmajid.dev/posts/2024-07-30-how-i-setup-btrfs-and-luks-on-nixos-using-disko/)
- [Install NixOS with disko disk partitioning](https://nixos.asia/en/nixos-install-disko)
- [The least painful way to set up a Windows VM on NixOS](https://crescentro.se/posts/windows-vm-nixos/)
