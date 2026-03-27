{ lib, config, ... }:

let
  # Modify git aliases so that they use difft as a difftool
  aliasesWithDifft = aliases:
    if config.programs.difftastic.enable then
      lib.mapAttrs (n: v: "-c diff.external=difft " + v + " --ext-diff") aliases
    else
      aliases;
in
{
  programs.git = {
    enable = true;
    signing.format = null; # Legacy behaviour was pgp
    settings = {
      init.defaultBranch = "main";
      user.name = "Levi van der Maas";
      user.useConfigOnly = true;
      advice.detachedHead = false;

      pretty.custom = "format:%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%w(0,10,10)%n%C(white)%s%C(reset) %C(dim white)- %an (%ae)%C(reset)%n%C(italic white)%+b%C(reset)";
      alias = {
        a = "add";
        c = "commit";
        s = "status";

        amend = "commit --amend";
        recommit = "commit --amend --date=now";
        softmerge = "merge --no-ff --no-commit";
        unstage = "restore --staged";

        setUserPersonal = "!git config user.name 'Levi van der Maas'; git config user.email 'levi.vdmaas@gmail.com'";
        setUserUni = "!git config user.name 'Levi van der Maas'; git config user.email 'l.a.vandermaas@student.tudelft.nl'";
      }
      // aliasesWithDifft {
        l = "log --graph --abbrev-commit --decorate --pretty=custom";
        graph = "log --graph --abbrev-commit --decorate --all --pretty=custom";

        about = "show --stat --pretty=custom";
        shortabout = "show --shortstat --pretty=custom";

        d = "diff";
        difft = "diff";
        ds = "diff --staged";
        dh = "diff HEAD";
      };
    };
  };
}
