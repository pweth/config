/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let 
  primary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg";
in
{
  "duckduckgo-api-key.age".publicKeys = [ primary ];
  "password-hash.age".publicKeys = [ primary ];
}
