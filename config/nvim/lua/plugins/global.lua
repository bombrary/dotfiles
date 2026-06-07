return {
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter" })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
        callback = function(ctx)
          pcall(vim.treesitter.start)
        end,
      })
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
  { "purescript-contrib/purescript-vim" },
}
