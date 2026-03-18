{ config, lib, fns, ... }:

let
  cfg = config.modules.hyprland;
  noctCall = mods: key: cmd: "${mods}, ${key}, exec, noctalia-shell ipc call ${cmd}";
  genNoctCalls = map (fns.apply noctCall);
in
{

  config = lib.mkIf cfg.enable {
    modules.noctalia-shell = {
        enable = true;
        targetDesktops = "Hyprland";
    };

    wayland.windowManager.hyprland.settings = {
      bind = genNoctCalls [
        [ "$mainMod" "SPACE" "launcher toggle" ]
        [ "$mainMod SHIFT" "SPACE" "launcher command" ]
        [ "$mainMod ALT" "SPACE" "launcher windows" ]
        [ "$mainMod" "X" "launcher clipboard" ]
      ];

      bindel = genNoctCalls [
        [ "" "XF86AudioRaiseVolume" "volume increase || wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" ]
        [ "" "XF86AudioLowerVolume" "volume decrease || wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" ]
        [ "" "XF86AudioMute" "volume muteOutput || wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ]
        [ "" "XF86AudioMicMute" "volume muteInput || wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ]
      ] ++ lib.optionals (!config.modules.noctalia-shell.enable) [
        [ "" "XF86MonBrightnessUp" "brightness increase" ]
        [ "" "XF86MonBrightnessDown" "brightness decrease" ]
      ];
    };
  };
}
