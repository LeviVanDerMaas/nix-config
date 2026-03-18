{ pkgs, config, lib, ... }:

let 
  cfg = config.modules.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      windowrule = [ 
        "match:initial_class org.pulseaudio.pavucontrol, float on, center on" # pavucontrol
        "match:initial_class nm-connection-editor, float on, center on" # nm-connection-editor
      ];
    };
  };
}
