/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  hosts = builtins.fromTOML (builtins.readFile ../hosts.toml);
  keys = builtins.mapAttrs (name: host: host.ed25519) hosts;
in
{
  "cloudflare.age".publicKeys = with keys; [ macaroni ];
  "gist.age".publicKeys = with keys; [ emperor ];
  "grafana.age".publicKeys = with keys; [ macaroni ];
  "nextdns.age".publicKeys = with keys; [ emperor gentoo macaroni rockhopper ];
  "password-hash.age".publicKeys = with keys; [ emperor gentoo macaroni rockhopper ];
  "rclone.age".publicKeys = with keys; [ emperor ];
  "tailscale.age".publicKeys = with keys; [ emperor gentoo macaroni rockhopper ];
  "wifi.age".publicKeys = with keys; [ emperor ];
}
