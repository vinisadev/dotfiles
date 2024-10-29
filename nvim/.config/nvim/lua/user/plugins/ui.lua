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

    -- dashboard
    {
      "goolord/alpha-nvim",
      lazy = false,
      config = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
██████╗  ██████╗ ███╗   ███╗ █████╗ ██╗███╗   ██╗███████╗ ██████╗ 
██╔══██╗██╔═══██╗████╗ ████║██╔══██╗██║████╗  ██║╚════██║██╔════╝ 
██║  ██║██║   ██║██╔████╔██║███████║██║██╔██╗ ██║    ██╔╝███████╗ 
██║  ██║██║   ██║██║╚██╔╝██║██╔══██║██║██║╚██╗██║   ██╔╝ ██╔═══██╗
██████╔╝╚██████╔╝██║ ╚═╝ ██║██║  ██║██║██║ ╚████║   ██║  ╚██████╔╝
╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═════╝ 
  ]]

        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
          dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
          dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
          dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
          dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
          dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }
        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.opts.opts.noautocmd = true

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyVimStarted",
          callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            dashboard.section.footer.val = "🎉 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end,
    },
}