{ pkgs, config, lib, ... }:

# NOTE: KDE seems to handle duplicate sections in the same file just fine
# and merges them internally (for duplicate keys, the last value is used).
# But if we ever get any weirdness, that might just be caused by that.
let
  cfg = config.modules.kdeConfig;
  toINI = lib.generators.toINI {};
in
{
  options.modules.kdeConfig = { 
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        A module to manually enforce KDE configuration. Can have wonky
        interaction while inside the DE. KDE should generally be able to
        gracefully handle not being allowed to write to them, but of course
        there is always the risk of wonkiness. As such you can disable this
        when you need to.
      '';
    };
    kdeglobals = lib.mkOption {
      type = with lib.types; coercedTo (attrsOf str) toINI lines;
      default = null;
      description = ''
        This file primarily stores information that should be applied "globally"
        throughout the DE. For example, Breeze and KDE-native apps read color scheme
        info from this fileAnd KDE-native apps find the default terminal to use here.
      '';
    };
    enforcePlatformtheme = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        On starting a session in KDE, sets `QT_QPA_PLATFORMTHEME=kde` for the full session.
        This ensures that while inside KDE, KDE manages Qt apps.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      kdeglobals = lib.optionalAttrs (cfg.kdeglobals != null) { text = cfg.kdeglobals; };
      "plasma-workspace/env/enforcePlatformtheme.sh" = lib.optionalAttrs cfg.enforcePlatformtheme { text = ''
        export QT_QPA_PLATFORMTHEME=kde
      '';};
    };

  };
}
