{ config, pkgs, lib, inputs, ... }:
{
  nix.enable = false;

  homebrew = {
    enable = true;
    casks = [
      "google-chrome"
      "discord"
      "visual-studio-code"
      "vlc"
      "logi-options+"
      "steam"
      "claude-code"
      "adobe-creative-cloud"
      "ghostty"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    checks.verifyNixPath = false;
    primaryUser = "lucas";
    stateVersion = 6;

    startup.chime = false;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        "com.apple.keyboard.fnState" = true;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
      dock = {
        autohide = true;
        orientation = "left";
        show-process-indicators = false;
        show-recents = false;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        FXRemoveOldTrashItems = true;
        _FXSortFoldersFirst = true;
      };
      controlcenter = {
        BatteryShowPercentage = true;
      };
      WindowManager.EnableStandardClickToShowDesktop = false;
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
