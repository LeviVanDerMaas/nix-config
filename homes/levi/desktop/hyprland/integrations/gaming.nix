{ pkgs, config, lib, ... }:

let
  cfg = config.modules.hyprland.integrations.gaming;
  initialLauncherClasses = [ "steam" ".*prismlauncher.*" ];
  initialGameClasses = [ "steam_app_.*" "gamescope" ".*Minecraft.*" ];
in
{
  options.modules.hyprland.integrations.gaming = {
    enable = lib.mkEnableOption ''
      Dedicate a workspace to gaming. That is, games and launchers will open
      on this workspace; games do so silently.
    '';
    gamingWorkspace = lib.mkOption {
      type = lib.types.either lib.types.int lib.types.str;
      default = 5;
      description = "Which workspace to designate as the gaming workspace";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      windowrule = map (ic: "match:initial_class ${ic}, workspace ${toString cfg.gamingWorkspace}") initialLauncherClasses
        ++ map (ic: "match:initial_class ${ic}, workspace ${toString cfg.gamingWorkspace} silent") initialGameClasses;
    };
  };
}
