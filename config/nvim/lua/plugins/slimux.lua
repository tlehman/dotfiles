return {
  {
    "EvWilson/slimux.nvim",
    config = function()
      local slimux = require("slimux")
      slimux.setup({
        target_socket = slimux.get_tmux_socket(),
        target_pane = string.format("%s.2", slimux.get_tmux_window()),
      })
      vim.keymap.set("v", "<leader>r", slimux.send_highlighted_text, { desc = "Send currently highlighted text to configured tmux pane" })
      vim.keymap.set("n", "<leader>r", slimux.send_paragraph_text, { desc = "Send paragraph under cursor to configured tmux pane" })
    end,
  },
}

