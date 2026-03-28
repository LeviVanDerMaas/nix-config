{ flake-inputs, flake-outputs, fns }@flakeSpecialPackages:

{
  # Add attributs of flakeSpecialPackages to `pkgs`. They are like `lib` or
  # `callPackage`; this is mainly to allow convenient access.
  flakeSpecialPackages = final: prev: { flake = flakeSpecialPackages; };

  # Temporary overlays, e.g. for applying fixes not yet in nixpkgs.
  temporary = final: prev: {
    # Works around a bug in less v691 and a weird interaction with xterm-kitty
    # (and possibly some other TERM types) where the search feature fails to
    # accept any input. Fixed in v692 but nixpkgs unstable often doesn't bump
    # version for months
    lessTERMOverride = fns.wrapPkgExeExternally {
      package = prev.less; wrapperArgs = [ "--set" "TERM" "xterm" ];
    };
  };
}
