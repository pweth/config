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

    # Home Server
    humboldt = {
      name = "humboldt";
      species = "Spheniscus humboldti";
      architecture = "x86_64-linux";
      ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZDBxFQIZaazAOgPCd9+eLxu7NAg+5a6ZwPmoI2eNGc";
      services = [
        "anki-sync"
        "blocky"
        "forgejo"
        "grafana"
        "immich"
        "jellyfin"
        "masked-email"
        "prometheus"
      ];
    };
  };

  keys = {
    # YubiKey 5 NFC
    igneous = {
      serial = 26624248;
      identity = "AGE-PLUGIN-YUBIKEY-1LPQFVQVZTTLEKRSJ220H5";
      age = "age1yubikey1qd7pcj57tnmwey27c6jj74uvu9eptjrkrflhysjgn6z74cs67a44k62qcc4";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKHts3hkSwRHwuxQYZDldRZ6Z+SDd3zXOxxX5fOmszD1AAAABHNzaDo=";
    };

    # YubiKey 5 NFC
    metamorphic = {
      serial = 26624249;
      identity = "AGE-PLUGIN-YUBIKEY-1L9QFVQVZGJG3YLQS0W4GX";
      age = "age1yubikey1qflj76esuc2w0ksxegtfxmmhsnskghws4gs34q6gnhxyz0g4zp0fzlw80v2";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKo1ORI0Ijxm+1VR5Ik5nHKisDIlQcwkZnCfr2xMJHVQAAAABHNzaDo=";
    };

    # YubiKey 5 Nano
    sedimentary = {
      serial = 23121828;
      identity = "AGE-PLUGIN-YUBIKEY-15N8KQQVZN5LEFZQ9KKSDH";
      age = "age1yubikey1q0sd4yd3t4e2jarc2xmufzkhryf42nrelrpagy24jq4suddqumkhzqy526m";
      ssh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKEju7zX5ohIuO3euGmMpHxU6vRu8kh9ma2OQP5PNj7vAAAABHNzaDo=";
    };
  };
}
