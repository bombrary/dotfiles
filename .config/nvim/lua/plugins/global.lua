return {
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
        ensure_installed = { "lua" },
        highlight = {
          enable = true,
        },
      }
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
  },
  {
    "mhartington/formatter.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    config = function()
      local util = require "formatter.util"

      require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          python = {
            require("formatter.filetypes.python").black,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      }
    end,
  },

}
