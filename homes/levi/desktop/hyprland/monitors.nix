{ config, lib, ... }:

let 
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland.monitors = lib.mkOption {
    description = ''
      Set up monior configuration. Furthermore, the first monitor will have
      workspaces 1 to 10 bound to it, the second monitor 11 to 20, and so on.
      First monitor will also be the cursor default.
    '';
    default = [];
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            The name parameter of Hyprland's "monitor" keyword.
          '';
        };
        resolution = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            The resolution parameter of Hyprland's "monitor" keyword.
          '';
        };
        position = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            The position parameter of Hyprland's "monitor" keyword.
          '';
        };
        scale = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            The scale parameter of Hyprland's "monitor" keyword.
          '';
        };
      };
    });
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      # The first rule will be a fallback rule, so that hotplugging unknown monitors should still work.
      monitor = [ ", preferred, auto, 1" ] ++
        map (mon: "${mon.name}, ${mon.resolution}, ${mon.position}, ${mon.scale}") cfg.monitors;

      # Make the first monitor the default monitor.
      cursor.default_monitor = lib.optional (cfg.monitors != []) (builtins.head cfg.monitors).name;

      workspace =
        let
          bindWsRangeToMonI = i: mon:
            let
              a = 10 * i + 1;
              b = a + 9;
            in
            map (w: "${toString w}, monitor:${mon.name}") (lib.range a b);
          bindsPerMon = lib.imap0 bindWsRangeToMonI cfg.monitors;
        in
        builtins.concatLists bindsPerMon;
    };
  };
}
