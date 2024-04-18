/*
* Bourne Again Shell configuration.
*/

{ config, hosts, ... }:

{
  programs.bash = {
    enable = true;

    # Command aliases
    shellAliases = {
      cf = "cd /etc/nixos/config";
      cls = "clear";
      c = "xclip -selection clipboard";
      df = "df -h";
      files = "fzf --preview 'bat --style=numbers --color=always --line-range :200 {}'";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gg = "git pull";
      gp = "git push";
      gr = "git reset";
      gs = "git status";
      ls = "eza -la";
      mkdir = "mkdir -p";
      nano = "nvim";
      ngc = "nix-collect-garbage -d";
      p = "xclip -o -selection clipboard";
      rb = "sudo nixos-rebuild switch --flake /etc/nixos/config";
      v = "nvim"; 
    };

    # Functions
    initExtra = ''
      gl () {
        git log --all --pretty=oneline --pretty=format:"%Cgreen%h%Creset %s" --color=always |
        fzf --ansi --preview 'git show --pretty=medium --color=always $(echo {} | cut -d " " -f 1)' |
        cut -d " " -f 1
      }
      fs-diff () {
        sudo mkdir -p /mnt &&
        sudo mount -o subvol=/ /dev/mapper/enc /mnt &&
        chmod +x /etc/nixos/config/static/scripts/fs-diff.sh &&
        /etc/nixos/config/static/scripts/fs-diff.sh
        sudo umount /mnt
      }
      secret () {
        (
          cd /etc/nixos/config/secrets &&
          sudo agenix \
          -i /etc/ssh/ssh_host_ed25519_key \
          -i /etc/nixos/config/static/keys/age-primary-identity \
          -e ''${1}.age
        )
      }
      weather () {
        curl -s "wttr.in/''${1}" | head -n -1
      }
    '';
  };
}
