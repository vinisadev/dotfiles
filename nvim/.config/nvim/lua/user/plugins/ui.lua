return {
  -- better vim.notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notfiy = require("notify")
    end,
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- bufferline
  {
    "akinsho/nvim-bufferline.lua",
    event = "BufAdd",
    config = true,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    evennt = "VeryLazy",
    config = true,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = {
      char = "▏",
    },
  },
}