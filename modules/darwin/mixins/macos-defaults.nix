{ lib, config, ... }:
{
  options.tlehman.macos-defaults.enable = lib.mkEnableOption "Tobi's macOS defaults";
  config = lib.mkIf config.tlehman.macos-defaults.enable {
    system.defaults.NSGlobalDomain = {
      # Disable "natural" scrolling (reverse scroll direction to traditional)
      "com.apple.swipescrolldirection" = false;
      # Enable Ctrl+Cmd+click anywhere to drag windows (like Linux)
      NSWindowShouldDragOnGesture = true;
    };
    system.defaults.dock.autohide = true;
  };
}
