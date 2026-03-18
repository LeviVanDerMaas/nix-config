vim.o.shiftwidth = 2;

local hostname = vim.uv.os_gethostname()
vim.lsp.config("nixd", {
  settings = {
    nixd = {
      options = {
        nixos = {
          expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations." .. hostname .. ".options"
        },
        -- Unfortunately, there isn't really a way for nixd to recognize when a file is for home_manager and when 
        -- it is for nixos, so it would just merge both option sets and display them across both files, which shows
        -- duplicate results as well as results that are not available for a specific file. Aditionally, when using
        -- home-manager as a nixos module it is unable to find any user-defined options, so for now we just don't enable it.
        -- home_manager = {
        --   expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations." .. hostname .. ".options.home-manager.users.type.getSubOptions []"
        -- }
      }
    }
  }
})
