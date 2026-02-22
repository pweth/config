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
      "db-browser-for-sqlite"
      "discord"
      "firefox"
      "handbrake-app"
      "iterm2"
      "libreoffice"
      "minecraft"
      "obs"
      "pinta"
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
