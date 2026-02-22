{ ... }:

{
  system.defaults = {
    # Activity Monitor
    ActivityMonitor = {
      IconType = 5;
      ShowCategory = 101;
    };

    # Control Center
    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = true;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
    };

    # Avoid creating .DS_Store files on network or USB volumes
    CustomUserPreferences."com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };

    # Dock
    dock = {
      autohide = true;
      autohide-time-modifier = 0.0;
      launchanim = false;
      mineffect = "scale";
      minimize-to-application = true;
      mru-spaces = false;
      show-recents = false;
      static-only = true;
    };

    # Finder
    finder = {
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      NewWindowTarget = "Home";
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # Login options
    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
      SHOWFULLNAME = true;
    };

    # Clock
    menuExtraClock = {
      FlashDateSeparators = false;
      Show24Hour = true;
      ShowDate = 1;
      ShowSeconds = true;
    };

    # Global settings
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      "com.apple.swipescrolldirection" = false;
      NSWindowResizeTime = 0.001;
    };

    # Disable wallpaper click
    WindowManager.EnableStandardClickToShowDesktop = false;
  };
}
