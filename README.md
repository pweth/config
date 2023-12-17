<div align="center">
<h1>🐧 Dotfiles</h1>
My NixOS configuration flake.
</div>

---

## Hosts

### Emperor

Dell Inc. XPS 13 9360 (i5-8250U, 8GB)

Dual-boot installation with Windows 11

### Macaroni

Oracle VM.Standard.A1.Flex (4 OCPUs, 24GB)

nixos-infect over Ubuntu Minimal 22.04

### Rockhopper

Raspberry Pi Model 3B+ (Cortex-A53, 1GB)

---

## Installation

1. Load up a [fresh NixOS installation](https://nixos.wiki/wiki/NixOS_Installation_Guide).
2. Update `/etc/ssh/ssh_host_ed25519_key` or generate using:
    ```bash
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N "" -t ed25519
    ```
3. Download this repository:
    ```bash
    nix-shell -p git --run "git clone https://github.com/pweth/dotfiles"
    ```
4. Update `hosts/HOST/hardware.nix` using `/etc/nixos/hardware-configuration.nix`.
5. Re-build the system using:
    ```
    sudo nixos-rebuild switch --flake /home/pweth/dotfiles#HOST
    ```

### Emperor Only

6. Update `~/.ssh/id_ed25519{,.pub}` then:
    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*
    ```
7. Download files from object storage using:
    ```bash
    sudo rclone copy backblaze-crypt: /home/pweth/Documents/ --config /run/agenix/rclone
    ```
8. Enable the rclone sync service using: 
    ```bash
    touch ~/.rclone_enable
    ```

---

## Notes

- [How to Install NixOS on Oracle ARM machine](https://blog.digitalimmigrants.org/deploy-nixos-on-oracle-arm-machines/)
- [Betterfox User Preferences](https://github.com/yokoffing/Betterfox)
- [Declarative Docker Container Service in NixOS](https://www.breakds.org/post/declarative-docker-in-nixos/)
- [NixOS on ARM/Raspberry Pi](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi)
- [Tracking SQLite Database Changes in Git](https://garrit.xyz/posts/2023-11-01-tracking-sqlite-database-changes-in-git)
- [Firefox Web Apps by TLATER](https://github.com/TLATER/dotfiles/blob/master/home-modules/firefox-webapp.nix)
