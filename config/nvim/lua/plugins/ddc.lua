return {
  {
    "Shougo/ddc.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-ui-native",
      "Shougo/ddc-source-around",
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-source-lsp",
    },
    event="InsertEnter",
    config = function()
      vim.fn["ddc#custom#patch_global"]({
        ui = "native",
        sources = { "around", "lsp" },
        sourceOptions = {
          around = {
            mark = "a",
            matchers = { "matcher_head" },
            sorters = { "sorter_rank" },
          },
          lsp = {
            mark = "lsp",
            forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
            sorters = { 'sorter_lsp-kind' },
          }
        },
      })
      vim.keymap.set('i', '<Tab>', function()
        if vim.fn.pumvisible() == 1 then
          return "<C-N>"
        else
          local col = vim.fn.col(".")
          if col <= 1 or string.match(string.sub(vim.fn.getline("."), col-1, col-1), "%s") then
            return "<Tab>"
          else
            vim.fn["ddc#map#manual_complete"]()
            return nil
          end
        end
      end, {expr = true})
      vim.keymap.set('i', '<S-Tab>', function()
        if vim.fn.pumvisible() == 1 then
          return "<C-p>"
        else
          return "<C-h>"
        end
      end, {expr = true})

      vim.fn["ddc#enable"]()
    end,
  },
}
