<!-- vim: set tw=80 spell: -->
# Personal NixOS + Home Manager configuration

My personal NixOS and Home Manager configuration, used to manage multiple
systems. The configuration follows a modular structure centered around a
**shared-by-default** approach. This makes it easy to keep a uniform setup
across systems and change or extend the config on the fly without disrupting the
overall structure, as well as allows device-specific tweaks without any hassle.

I began daily-driving NixOS halfway through 2024, but this repo was created in
2026 after heavily revamping my 300+ commit "temporary" config to make it easier
to apply changes and maintain for long-term use.

## Structure

- `nixos/` and `homes/` contain baseline configuration for NixOS and Home
Manager, respectively. For both NixOS and Home Manager, options for custom
modules are defined under the `config.modules.<moduleName>` attribute.

- `systems/` contains the entry points for each individual system, as well as
any system-specific configuration tweaks. This includes system-specific tweaks
to Home Manager, by passing an extra module with these tweaks to Home Manager
from here.

- `overlays/` contains nixpkgs overlays to be used by both the NixOS and Home
Manager configs.

- `fns/` contains custom Nix functions and values used throughout the config.

- `assets/` contains non-config files, such as wallpapers.

### System-Specific configuration

The modular structure combined with the **shared-by-default** approach makes it
easy to manage all system-specific configuration from a single file per system,
e.g. as I do in `systems/<system>/configuration.nix`. For the same reason, I
often don't write custom options for modules when not needed for my purposes:
should they be needed down the line, it's very easy to add them without any
additional integration work.

## Systems

- **boo**: My primary desktop, used for everything from study and work to gaming
and hobby projects, and behind which I spend a considerable portion of both my
leisure and non-leisure time.

- **lucy**: My laptop, primarily used for study and work.

- **buffon**: A desktop I occasionally use for similar purposes as *boo*,
although it has older hardware and a somewhat more haphazard setup.
