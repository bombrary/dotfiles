local function get_current_buf_text()
  local _, srow, scol, _ = unpack(vim.fn.getpos("."))
  local _, erow, ecol, _ = unpack(vim.fn.getpos("v"))
  if srow < erow or (srow == erow and scol <= ecol) then
    return vim.api.nvim_buf_get_text(0, srow-1, scol-1, erow-1, ecol, {})
  else
    return vim.api.nvim_buf_get_text(0, erow-1, ecol-1, srow-1, scol, {})
  end
end

return {
  { 
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-source-file_rec",
      "shun/ddu-source-buffer",
      "shun/ddu-source-rg",
      "yuki-yano/ddu-filter-fzf",
      "Shougo/ddu-kind-file",
    },
    config = function()
      vim.fn["ddu#custom#patch_global"]({
        ui = {
          name = "ff",
        },
        sourceOptions = {
          _ = {
            matchers = { "matcher_fzf" },
            sorters = { "sorter_fzf" },
          },
        },
        filterParams = {
          matcher_fzf = {
            highlightMatched = "Search",
          },
        },
        kindOptions = {
          file = {
            defaultAction = "open",
          },
        },
      })

      vim.fn["ddu#custom#patch_local"]("files", {
        sources = {
          {
            name = "file_rec",
            params = {
              path = vim.fn.expand("~"),
            },
          },
        },
      })

      vim.fn["ddu#custom#patch_local"]("buffers", {
        sources = {
          {
            name = "buffer",
          },
        },
      })

      vim.fn["ddu#custom#patch_local"]("rg", {
        sources = {
          {
            name = "rg",
            params = {
              args = { "--json", "--hidden" },
            },
          },
        },
      })

      vim.keymap.set("n", ",f", function() vim.fn["ddu#start"]({ name = "files" }) end)
      vim.keymap.set("n", ",b", function() vim.fn["ddu#start"]({ name = "buffers" }) end)
      vim.keymap.set("v", ",g", function()
        local lines = get_current_buf_text()
        local text = table.concat(lines, "\n")
        vim.fn["ddu#start"]({ name = "rg", sourceParams = { rg = { input = text } } })
      end)
      vim.keymap.set("n", ",g", function()
        local text = vim.fn.input("keyword: ")
        vim.fn["ddu#start"]({ name = "rg", sourceParams = { rg = { input = text } } })
      end)


      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "ddu-ff" },
        callback = function(ev)
          vim.keymap.set("n", "<CR>", function() vim.fn["ddu#ui#do_action"]("itemAction") end, { buffer = true })
          vim.keymap.set("n", "q", function() vim.fn["ddu#ui#do_action"]("quit") end, { buffer = true })
          vim.keymap.set("n", "i", function() vim.fn["ddu#ui#do_action"]("openFilterWindow") end, { buffer = true })
        end
      })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "ddu-ff-filter"},
        callback = function(ev)
          vim.keymap.set("i", "<CR>", function() 
            vim.cmd('stopinsert')
            vim.fn["ddu#ui#do_action"]("closeFilterWindow")
          end, { buffer = true })
          vim.keymap.set("n", "<CR>", function()
            vim.fn["ddu#ui#do_action"]("closeFilterWindow")
          end, { buffer = true })
        end
      })
    end,
  }
}
