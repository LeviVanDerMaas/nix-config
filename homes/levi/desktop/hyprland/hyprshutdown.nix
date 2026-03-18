{ pkgs, lib, config, ... }:

let
  cfg = config.modules.hyprland;
in
lib.mkIf cfg.enable {
  home.packages = with pkgs; [ hyprshutdown ];
  wayland.windowManager.hyprland.settings.bind = [
    "$allMods, E, exec, hyprshutdown -t 'Exiting Hyprland...'"
    "$allMods, P, exec, hyprshutdown -t 'Shutting down...' --post-cmd 'poweroff'"
    "$allMods, R, exec, hyprshutdown -t 'Rebooting...' --post-cmd 'reboot'"
  ];
}
