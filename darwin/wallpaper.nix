{ pkgs, ... }:
let
  script = pkgs.writeShellScriptBin "update-wallpaper" ''
    ${pkgs.curl}/bin/curl -L "https://pweth.com/noindex/img/background.jpg" -o "$HOME/Wallpaper.tmp.jpg" \
      && mv "$HOME/Wallpaper.tmp.jpg" "$HOME/Wallpaper.jpg"
    /usr/bin/osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Wallpaper.jpg\""
    /usr/bin/killall WallpaperAgent
  '';
in
{
  # Script package
  environment.systemPackages = [ script ];

  # Launchd service
  launchd.user.agents.update-wallpaper = {
    serviceConfig = {
      ProgramArguments = [ "${script}/bin/update-wallpaper" ];
      RunAtLoad = true;
      StartInterval = 3600;
    };
  };
}
