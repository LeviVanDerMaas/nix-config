{ flake-inputs, ... }:

{
  imports = [ flake-inputs.levisNeovimConfig.homeManagerModules.default ];

  config = {
    programs.levisNeovimConfig.enable = true;
  };
}
