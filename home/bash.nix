# * Bourne Again Shell configuration.

{ config, hosts, ... }:

{
  programs.bash = {
    enable = true;

    # Command aliases
    shellAliases = {
      cf = "cd /etc/nixos/config";
      cls = "clear";
      copy = "xclip -selection clipboard";
      df = "df -h";
      files = "fzf --preview 'bat --style=numbers --color=always --line-range :200 {}'";
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gd = "git diff";
      gg = "git pull";
      gp = "git push";
      gr = "git reset";
      grrr = "git reset --hard";
      gs = "git status";
      i = "grep";
      ls = "eza -la";
      mkdir = "mkdir -p";
      nano = "nvim";
      paste = "xclip -o -selection clipboard";
      pi = "pip install .";
      rb = "sudo nixos-rebuild switch --flake /etc/nixos/config";
      src = "source";
      ta = "tmux attach";
      tcls = "tmux kill-session -a";
      tkill = "tmux kill-server";
      tls = "tmux list-sessions";
      tn = "tmux new-session";
      v = "nvim";
    };

    # Functions
    initExtra = ''
      gl () {
        git log --all --pretty=oneline --pretty=format:"%Cgreen%h%Creset %s" --color=always |
          fzf --ansi --preview 'git show --pretty=medium --color=always $(echo {} | cut -d " " -f 1)' |
          cut -d " " -f 1
      }

      ngc () {
        nix profile wipe-history
        nix store gc
        nix store optimise
      }

      run () {
        nix search nixpkgs . --json > /tmp/nixpkgs
        PKG=$(cat /tmp/nixpkgs |
          jq -r 'keys | .[]' |
          awk -F '.' '{for (i=3; i<NF; i++) printf $i "."; print $NF}' |
          fzf)
        cat /tmp/nixpkgs | jq ".\"legacyPackages.x86_64-linux.$PKG\""
        nix-shell -p $PKG
      }

      weather () {
        curl -s wttr.in/$(jq -rn --arg x "$*" '$x|@uri') | head -n -1
      }
    '';
  };
}
