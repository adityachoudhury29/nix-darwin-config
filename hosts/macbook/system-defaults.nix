# macOS system defaults (nicknamed "defaultswrite" config).
# Safe to set; GUI apps can be configured here instead of via System Settings.
{
  config,
  pkgs,
  lib,
  ...
}:

{
  system.defaults = {
    # --- Dock ---
    # Keep the Dock visible (don't auto-hide on rebuild).
    dock.autohide = false;
    dock.mru-spaces = false;
    dock.orientation = "bottom";
    dock.show-recents = false;

    # --- Finder ---
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = false;
    finder.FXPreferredViewStyle = "clmv"; # column view

    # --- Global keyboard / input ---
    NSGlobalDomain.AppleKeyboardUIMode = 3;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

    # --- Login / screensaver ---
    loginwindow.GuestEnabled = false;
    screensaver.askForPasswordDelay = 10;
  };

  # --- Trackpad: natural scrolling off, tap to click on ---
  # (managed via defaults below; requires the "com.apple.AppleMultitouchTrackpad" domain)
}