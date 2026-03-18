{ lib, fns, flake-inputs, config, ... }:

let
  cfg = config.modules.users.levi;
in
{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
  ];

  options.modules.users.levi = {
    enable = lib.mkEnableOption "Set up levi as user";

    extraHMConfig = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = ''
        Extra config added to levi's Home Manager config. Mainly useful
        to allow systems to pass in sytem-specific tweaks to levi's Home Manager
        config. Note this shouldn't be a module, just an attrset for the `config`
        attribute of a Home Manager module.
      '';
    };
  };

  config = {
    users.users.levi = {
      isNormalUser = true;
      description = "Levi";
      extraGroups = [ "networkmanager" "wheel" "i2c" ];
    };

    home-manager.users.levi = { ... }: {
      imports = [ (fns.rootRel /homes/levi) ];
      config = cfg.extraHMConfig;
    };
  };
}
