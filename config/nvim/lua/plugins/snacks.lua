return {
  {
    "folke/snacks.nvim",
    priority = 1000, -- Ensure early loading
    lazy = false, -- Load immediately
    opts = {
      -- Enable specific snacks plugins
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      picker = { enabled = true },
      -- Add other plugins as needed (see full list in [1][9])
    },
  },
}
