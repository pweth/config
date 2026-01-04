{
  hosts = {
    # Desktop
    adelie = {
      name = "adelie";
      species = "Pygoscelis adeliae";
      architecture = "x86_64-linux";
      ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALl6nmhTzqES2qmootEZ6x8DuomSvJCzYTormEevq4y";
      services = [ ];
    };

    # Application Server
    humboldt = {
      name = "humboldt";
      species = "Spheniscus humboldti";
      architecture = "x86_64-linux";
      ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZDBxFQIZaazAOgPCd9+eLxu7NAg+5a6ZwPmoI2eNGc";
      services = [
        "forgejo"
        "grafana"
        "immich"
        "masked-email"
        "minecraft"
        "prometheus"
      ];
    };

    # Media Server
    macaroni = {
      name = "macaroni";
      species = "Eudyptes chrysolophus";
      architecture = "x86_64-linux";
      ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4rxqM0nNOkhGAg3HrvYngWE6ro/BivxbED4nqS4KxV";
      services = [
        "jellyfin"
        "usenet"
      ];
    };

    # Raspberry Pi
    rockhopper = {
      name = "rockhopper";
      species = "Eudyptes moseleyi";
      architecture = "aarch64-linux";
      ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDw/Rhr1cdwp3RIwmxTWBa1tWA3gzMyyC8YTJNMN0Fbf";
      services = [ ];
    };
  };

  keys = {
    # YubiKey 5 NFC
    igneous = {
      identity = "AGE-PLUGIN-YUBIKEY-1LPQFVQVZTTLEKRSJ220H5";
      age = "age1yubikey1qd7pcj57tnmwey27c6jj74uvu9eptjrkrflhysjgn6z74cs67a44k62qcc4";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKHts3hkSwRHwuxQYZDldRZ6Z+SDd3zXOxxX5fOmszD1AAAABHNzaDo=";
    };

    # YubiKey 5 NFC
    metamorphic = {
      identity = "AGE-PLUGIN-YUBIKEY-1L9QFVQVZGJG3YLQS0W4GX";
      age = "age1yubikey1qflj76esuc2w0ksxegtfxmmhsnskghws4gs34q6gnhxyz0g4zp0fzlw80v2";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKo1ORI0Ijxm+1VR5Ik5nHKisDIlQcwkZnCfr2xMJHVQAAAABHNzaDo=";
    };

    # YubiKey 5 Nano
    sedimentary = {
      identity = "AGE-PLUGIN-YUBIKEY-15N8KQQVZN5LEFZQ9KKSDH";
      age = "age1yubikey1q0sd4yd3t4e2jarc2xmufzkhryf42nrelrpagy24jq4suddqumkhzqy526m";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKEju7zX5ohIuO3euGmMpHxU6vRu8kh9ma2OQP5PNj7vAAAABHNzaDo=";
    };
  };
}
