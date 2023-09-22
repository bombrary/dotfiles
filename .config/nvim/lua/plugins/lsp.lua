return {
  {
    "Shougo/ddc.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-nvim-lsp",
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-ui-native",
      "L3MON4D3/LuaSnip",
    },
    event = 'InsertEnter',
    config = function() 
      vim.fn['ddc#custom#patch_global']({
        ui = 'native',
        sources = { 'around', 'nvim-lsp' },
        sourceOptions = {
          ['around'] = {
            mark = 'A',
          },
          ['nvim-lsp'] = {
            mark = 'lsp',
            dup = 'keep',
            keywordPattern = '\\k+',
            sorters = { 'sorter_lsp-kind' },
          },
          _ = {
            matchers = { 'matcher_head' },
            sorters = { 'sorter_rank' }
          }
        },
        sourceParams = {
            ['nvim-lsp'] = {
              enableResolveItem = true,
              enableAdditionalTextEdit = true,
              confirmBehavior = 'replace',
            },
        },
      })
      vim.fn["denops#callback#register"](function(body)
        require('luasnip').lsp_expand(body)
      end)

      vim.keymap.set('i', '<Tab>', function()
        if vim.fn.pumvisible() == 1 then
          return "<C-n>"
        else
          local pos = vim.inspect_pos()
          if pos.col <= 0 then
            return "<Tab>"
          end
          local c = vim.api.nvim_get_current_line():sub(pos.col, pos.col)
          if string.match(c, "%s") then
            return "<Tab>"
          else
            vim.fn["ddc#map#manual_complete"]()
          end
        end
      end, { expr = true })
      vim.fn['ddc#enable']()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Shougo/ddc.vim",
      "purescript-contrib/purescript-vim",
      "uga-rosa/ddc-nvim-lsp-setup",
    },
    config = function()
      require("ddc_nvim_lsp_setup").setup()

      -- Setup language servers.
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.terraform_lsp.setup{}
      lspconfig.rust_analyzer.setup {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ['rust-analyzer'] = {},
        },
      }
      lspconfig.gopls.setup {}

      lspconfig.purescriptls.setup {}
      lspconfig.elmls.setup {}


      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', 'd]', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        pattern = '*.py',
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local path = vim.fn.expand("%:p")
          vim.keymap.set('n', '<space>f', function()
            vim.fn.execute(":w")
            local res = vim.fn.system({
              "black",
              path,
            })
            vim.notify(res, vim.log.levels.INFO)
            vim.fn.execute(":e")
          end, opts)
        end,
      })

    end,
  },
  {
    "matsui54/denops-signature_help",
    config = function()
     vim.fn['signature_help#enable']()
    end
  },
  {
    "matsui54/denops-popup-preview.vim",
    config = function()
     vim.fn['popup_preview#enable']()
    end
  },
}
