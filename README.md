<div align="center">
<h1>🐧 Config</h1>
NixOS configuration flake.
</div>

---

## Devices

| Hostname | System |
| --- | --- |
| Adelie | Dell Precision 3280 |
| Chinstrap | Cisco Catalyst 1200 Series Switch |
| Emperor | Dell XPS 13 9360 |
| Humboldt | Dell OptiPlex 3050 Micro |
| Rockhopper | Raspberry Pi Model 3B+ |

---

## Installation

1. Load up a [fresh NixOS installation](https://nixos.wiki/wiki/NixOS_Installation_Guide).
2. Update `/etc/ssh/ssh_host_ed25519_key` or generate using:
    ```
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N "" -t ed25519
    ```
3. Clone this repository:
    ```
    nix-shell -p git
    git clone git@github.com:pweth/config.git
    ```
4. Update `flake.nix` and `hosts/HOST.nix` as required.
5. Re-build the system using:
    ```
    sudo nixos-rebuild switch --flake /etc/nixos/config#HOST
    ```

---

## Notes

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
