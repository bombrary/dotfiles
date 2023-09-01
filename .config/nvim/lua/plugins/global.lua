return {
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-buffer",
      "Shougo/ddu-filter-matcher_substring",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-ui-ff",
    },
    config = function()
      vim.cmd([[
        call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sources': [{'name': 'file_rec', 'params': {}}],
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_substring'],
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \   }
      \ })
      ]])

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff',
        callback = function(ev)
          vim.cmd([[
            nnoremap <buffer><silent> <CR>
                  \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
            nnoremap <buffer><silent> <Space>
                  \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
            nnoremap <buffer><silent> i
                  \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
            nnoremap <buffer><silent> q
                  \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
          ]])
        end
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff-filter',
        callback = function(ev)
          vim.cmd([[
            inoremap <buffer><silent> <CR>
            \ <Esc><Cmd>call ddu#ui#ff#do_action("closeFilterWindow")<CR>
            nnoremap <buffer><silent> <CR>
            \ <Cmd>call ddu#ui#ff#do_action("closeFilterWindow")<CR>
            nnoremap <buffer><silent> q
            \ <Cmd>call ddu#ui#ff#do_action("closeFilterWindow")<CR>
          ]])
        end
      })
      vim.keymap.set('n', ',f', '<Cmd>call ddu#start({})<CR>', opt)
      vim.keymap.set('n', ',b', '<Cmd>call ddu#start({\'sources\': [{\'name\': \'buffer\', \'params\': {}}] })<CR>', opt)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
      }
    end,
  }
}
