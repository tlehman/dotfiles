{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.neovim.enable = lib.mkEnableOption "Neovim with LazyVim";

  config = lib.mkIf config.tlehman.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = false;
      viAlias = true;
      vimAlias = true;
    };

    # LazyVim starter configuration
    xdg.configFile."nvim/init.lua".text = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';
  };
}
