{ pkgs, lib, config, ... }:

let
  cfg = config.modules.hyprland;
in
lib.mkIf cfg.enable {
  home.packages = with pkgs; [ hyprpolkitagent ];
  wayland.windowManager.hyprland.settings.exec-once = [ "systemctl --user start hyprpolkitagent" ];
}
