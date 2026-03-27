{ config, ... }:

{
  programs.difftastic = {
    enable = true;
    # Note that enabling difftastic as the default git diffvierwer like this
    # is gonna mess with things like fugitive.vim and telescope.nvim
    # git = {
    #   enable = true;
    #   diffToolMode = true;
    # };
  };
}
