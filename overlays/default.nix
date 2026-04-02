{ flake-inputs, flake-outputs, fns }@flakeSpecialPackages:

{
  # Add attributs of flakeSpecialPackages to `pkgs`. They are like `lib` or
  # `callPackage`; this is mainly to allow convenient access.
  flakeSpecialPackages = final: prev: { flake = flakeSpecialPackages; };

  # Temporary overlays, e.g. for applying fixes not yet in nixpkgs.
  temporary = final: prev: {
  };
}
