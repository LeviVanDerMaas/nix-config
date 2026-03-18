{ pkgs, config, lib, ... }:

let 
  cfg = config.modules.hyprland.integrations.discord;
in
{
  options.modules.hyprland.integrations.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.hyprland.enable;
      description = ''
        Integrates Discord by setting up a special workspace for it.
      '';
    };
    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Starts Discord alongside Hyprland.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      workspace = [
        "special:discord, on-created-empty:discord"
      ];

      windowrule = [
        # "workspace special:discord silent, class:(discord)"
        "match:class discord, workspace special:discord"
      ];

      exec-once = lib.optionals cfg.autoStart [ "discord" ];

      bind = [
        "$mainMod, V, togglespecialworkspace, discord"
        "$mainMod, V, movetoworkspace, special:discord,class:discord"
      ];
    };
  };
}
