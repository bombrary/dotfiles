return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Shougo/ddc-source-lsp",
    },
    config = function()
      vim.lsp.config('*', {
        capabilities = require('ddc_source_lsp').make_client_capabilities(),
      })

      -- Setup language servers.
      vim.lsp.enable("pyright")
      vim.lsp.enable("gopls")
      vim.lsp.enable("purescriptls")
      vim.lsp.enable("rust_analyzer")

      vim.lsp.enable("denols")
      -- lspconfig.denols.setup {
      --   root_dir = lspconfig.util.root_pattern("denops/"),
      --   init_options = {
      --     lint = true,
      --     unstable = true,
      --   },
      --   capabilities = capabilities
      -- }

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>

          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
    end,
  },
  {
    "matsui54/denops-signature_help",
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
     vim.fn['signature_help#enable']()
    end
  },
  {
    "matsui54/denops-popup-preview.vim",
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
     vim.fn['popup_preview#enable']()
    end
  },
}
