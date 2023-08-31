let 
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg me@pweth.com";
in
{
  "duckduckgo-api-key.age".publicKeys = [ key ];
  "internetas.age".publicKeys = [ key ];
  "password-hash.age".publicKeys = [ key ];
}
