{ ... }:

{
  homebrew = {
    enable = true;

    # Settings
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
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
      "handbrake-app"
      "libreoffice"
      "obs"
      "pinta"
      "secretive"
      "spotify"
      "tailscale-app"
      "visual-studio-code"
      "vlc"
      "webex"
      "wireshark-app"
      "zoom"
    ];
  };
}
