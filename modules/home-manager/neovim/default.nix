{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.neovim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf config.tlehman.neovim.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs) lazygit;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = builtins.attrValues {
        inherit (pkgs.vimPlugins) nvim-tree-lua nvim-web-devicons lazygit-nvim;
      };
      extraLuaConfig = ''
        -- Leader key
        vim.g.mapleader = " "

        -- Tabs: size 4
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
        vim.opt.expandtab = true

        -- Cursorline: subtle but visible in both dark and light modes
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })

        local function set_cursorline()
          if vim.o.background == "dark" then
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a2e" })
          else
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#e8e8ec" })
          end
        end

        set_cursorline()
        vim.api.nvim_create_autocmd("OptionSet", {
          pattern = "background",
          callback = set_cursorline,
        })

        -- nvim-tree
        require("nvim-tree").setup()
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File tree" })

        -- lazygit
        vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
      '';
    };
  };
}
