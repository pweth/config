#!/usr/bin/env bash

# Target hostname
read -p "Hostname: " hostname
read -p "IP Address: " ip

# Create a temporary directory
temp=$(mktemp -d)

# Function to clean up temporary directory on exit
cleanup() {
  rm -rf "$temp"
}
trap cleanup EXIT

# Create directory structure
install -d -m755 "$temp/boot"
install -d -m755 "$temp/etc/ssh"
install -d -m755 "$temp/persist/etc/ssh"

# Decrypt private keys from passage
echo "Decrypting ecdsa key..."
passage "ssh/initramfs" > "$temp/boot/ecdsa.key"
echo "Decrypting ed25519 key..."
passage "ssh/$hostname" > "$temp/etc/ssh/ssh_host_ed25519_key"
cp "$temp/etc/ssh/ssh_host_ed25519_key" "$temp/persist/etc/ssh/ssh_host_ed25519_key"

# Set the correct permissions
chmod 600 "$temp/etc/ssh/ssh_host_ed25519_key"
chmod 600 "$temp/persist/etc/ssh/ssh_host_ed25519_key"

# Install NixOS
nixos-anywhere \
    --extra-files "$temp" \
    --flake ".#$hostname" \
    --target-host "nixos@$ip"
