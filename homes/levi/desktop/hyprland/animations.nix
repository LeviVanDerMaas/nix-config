{ config, lib, ... }:

let
  cfg = config.modules.hyprland;
in
lib.mkIf cfg.enable {
  wayland.windowManager.hyprland.settings = {
    bezier = [
      # Does about 75% in the first 1/10th of the time, easing out the last 25%
      # in the rest.
      "easeOut, 0.05, 1, 0.1, 1"
      "easeOutBob, 0.05, 1, 0.1, 1.05"

      # Transition starts at approx 0.87 at a slope of about 35 degrees
      # (eyeballed), the curve then  gradually flattens out till it reaches
      # 1. Has the effect of making very fast transition times over larger
      # distances still look smooth while maintaining snappyness, but the
      # skipping of most of the transition becomes noticeable when there are
      # more than two moving components with this transition at once.
      "87easeOut, -0.5,1,0.20,1"
    ];

    # NOTE: For animations that allow "fade" as a style, the fade is not controlled by
    # that animation's speed and curve but rather by the fade-subtree, EXCEPT for workspaces(???).
    # NOTE: Closing animations for windows will not work unless a fade animation is set,
    # otherwise the window will just instantly disappear (intended behavior, but undocumented
    # on the wiki). Might be fixed later https://github.com/hyprwm/Hyprland/issues/10352
    animation = [
      "fade, 1, 6, easeOut" # Base fade for all but workspaces

      "windowsIn, 1, 3, easeOutBob, popin"
      "windowsMove, 1, 3, easeOutBob, popin"
      "windowsOut, 1, 6, easeOut, popin 50%"

      "layers, 1, 3, easeOut, fade"

      "workspaces, 1, 3, 87easeOut, slide"
      "specialWorkspace, 1, 3, easeOut, slidefadevert 20%"
      "border, 1, 3, easeOut"
    ];
  };
}
