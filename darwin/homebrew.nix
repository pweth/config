{ ... }:

{
  homebrew = {
    enable = true;

    # Settings
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--force" ];
      upgrade = true;
    };

    # Packages
    casks = [
      "anki"
      "citrix-workspace"
      "claude"
      "db-browser-for-sqlite"
      "discord"
      "firefox"
      "google-chrome"
      "handbrake-app"
      "logi-options+"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "minecraft"
      "obs"
      "pinta"
      "secretive"
      "spotify"
      "tailscale-app"
      "visual-studio-code"
      "vlc"
      "webex"
      "whatsapp"
      "wireshark-app"
      "zoom"
    ];
  };
}
