{ host, ... }:

{
  # User account
  users.users.pweth = {
    createHome = true;
    description = "Peter";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # Igneous
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINMlIBsBv4stEDgGXqEmqU+yQJ6sisg2LHc6BGvk2YhlAAAABHNzaDo="
      # Metamorphic
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIRMh2949EjLqpEkvOrlXDXevuUQVnPhvrSySvtNzqGnW5vFMvsVwaUkd2UFf3ukgMgb4KXwTWlBki664itrE8c="
      # Sedimentary
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKEju7zX5ohIuO3euGmMpHxU6vRu8kh9ma2OQP5PNj7vAAAABHNzaDo="
    ];
    uid = 1000;
  };

  # Message of the day
  users.motd = "Connected to ${host.species}.";

  # Immutable users
  users.mutableUsers = false;
}
