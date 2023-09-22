return {
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  }, {
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-buffer",
      "Shougo/ddu-source-rg",
      "Shougo/ddu-filter-matcher_substring",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-ui-ff",
    },
    config = function()
      vim.fn['ddu#custom#patch_global']({
        ui = 'ff',
        sources = {{name = 'file_rec', params = {}}},
        sourceOptions = {
          _ = {
            matchers = {'matcher_substring'},
          },
        },
        sourceParams = {
          _ = {
            matchers = {'matcher_substring'},
          },
          rg = {
            args = { '--column', '--no-heading', '--color', 'never', '--json'},
          }
        },
        kindOptions = {
          file = {
            defaultAction = 'open',
          },
        },
        uiParams = {
          ff = {
            split = 'floating',
	          previewFloating = true,
          },
        },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff',
        callback = function(ev)
          vim.keymap.set('n', '<CR>', function()
            vim.fn['ddu#ui#ff#do_action']('itemAction')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', '<Space>', function()
            vim.fn['ddu#ui#ff#do_action']('toggleSelectItem')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'i', function()
            vim.fn['ddu#ui#ff#do_action']('openFilterWindow')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'p', function()
            vim.fn['ddu#ui#ff#do_action']('preview')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'q', function()
            vim.fn['ddu#ui#ff#do_action']('quit')
          end, { silent=true, buffer=true })
        end
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff-filter',
        callback = function(ev)
          vim.keymap.set('i', '<CR>', function()
            vim.api.nvim_input("<ESC>")
            vim.fn['ddu#ui#ff#do_action']('closeFilterWindow')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', '<CR>', function()
            vim.fn['ddu#ui#ff#do_action']('closeFilterWindow')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'q', function()
            vim.fn['ddu#ui#ff#do_action']('closeFilterWindow')
          end, { silent=true, buffer=true })
        end
      })

      vim.keymap.set('n', ',f', function()
        vim.fn['ddu#start']()
      end)

      vim.keymap.set('n', ',b', function()
        vim.fn['ddu#start']({
          sources = {
            { name = 'buffer',
              params = {}
            }
          }
        })
      end)

      vim.api.nvim_create_user_command('Grep', function(args)
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'rg',
              params = {
                input = args['args']
              },
            },
          }
        })
      end, {})

    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        ignore_installed = { "yaml" },
        highlight = {
          disable = { "yaml" },
          enable = true,
        },
      }
    end,
  }
}
