{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v4.6.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    levisNeovimConfig = {
      url = "github:LeviVanDerMaas/neovim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@flake-inputs:
    let
      flake-outputs = self.outputs;
      arch = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${arch};
      lib = nixpkgs.lib;
      fns = import ./fns { inherit pkgs lib; };

      systemConfigFor = system:
        let
          systemConfiguration = import ./systems/${system}/configuration.nix;
        in
        lib.nixosSystem {
          specialArgs = { inherit flake-inputs flake-outputs fns; };
          modules = [ systemConfiguration ];
        };
      systemConfigsFor = systems: lib.genAttrs systems systemConfigFor;
    in
    {
      overlays = import ./overlays { inherit flake-inputs flake-outputs fns; };

      nixosConfigurations = systemConfigsFor [
        "boo"
        "lucy"
        "buffon"
      ];
    };
}
