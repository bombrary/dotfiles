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
    "ddu-test",
    dir = "~/tmp/ddu-test"
  },
  {
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-buffer",
      "Shougo/ddu-source-rg",
      "yuki-yano/ddu-filter-fzf",
      "uga-rosa/ddu-filter-converter_devicon",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-ui-ff",
      "ddu-test",
    },
    config = function()
      local lines = vim.opt.lines:get()
      local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
      local columns = vim.opt.columns:get()
      local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)

      vim.fn['ddu#custom#patch_global']({
        ui = 'ff',
        sources = {{name = 'file_rec', params = {}}},
        sourceOptions = {
          _ = {
            matchers = {'matcher_fzf'},
            sorters = {'sorter_fzf'},
            converters = { 'converter_devicon' },
          },
        },
        sourceParams = {
          rg = {
            args = { '--column', '--no-heading', '--color', 'never', '--json'},
          }
        },
        filterParams = {
          matcher_fzf = {
            highlightMatched = 'Search',
          },
        },
        kindOptions = {
          file = {
            defaultAction = 'open',
          },
          sample = {
            defaultAction = 'echo',
          },
        },
        uiParams = {
          ff = {
            startFilter = true,
            prompt = "> ",
            cursorPos = 0,
            split = "floating",
            floatingBorder = "single",
            filterFloatingPosition = "top",
            --autoAction = {
            --  name = "preview",
            --},
            --startAutoAction = true,
            previewFloating = true,
            previewFloatingBorder = "single",
            previewSplit = "vertical",
            previewFloatingTitle = "Preview",
            previewWindowOptions = {
              { "&signcolumn", "no" },
              { "&foldcolumn", 0 },
              { "&foldenable", 0 },
              { "&number", 0 },
              { "&wrap", 0 },
              { "&scrolloff", 0 },
            },
            highlights = {
              floating = "Normal",
              floatingBorder = "Normal",
            },
            ignoreEmpty = true,
          },
        },
      })

      local function resize()
        local lines = vim.opt.lines:get()
        local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
        local columns = vim.opt.columns:get()
        local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)
        local previewWidth = math.floor(width / 2)

        vim.fn['ddu#custom#patch_global']({
          uiParams = {
            ff = {
              winHeight = height,
              winRow = row,
              winWidth = width,
              winCol = col,
              previewHeight = height,
              previewRow = row,
              previewWidth = previewWidth,
              previewCol = col + (width - previewWidth),
            },
          },
        })
      end

      resize()

      vim.api.nvim_create_autocmd("VimResized", {
        callback = resize,
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

      vim.keymap.set('v', ',g', function()
        local lines = get_current_buf_text()
        local text = table.concat(lines, "\n")

        vim.fn['ddu#start']({
          sources = {
            {
              name = 'rg',
              params = {
                input = text
              },
            },
          }
        })
      end)

      vim.keymap.set('n', ',g', function()
        text = vim.fn.input("keyword: ")
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'rg',
              params = {
                input = text
              },
            },
          }
        })
      end)

      vim.keymap.set('n', ',s', function()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'sample',
              params = {},
            },
          },
        })
      end)

    end,
  },
  {
    "Shougo/ddu-ui-filer",
    dependencies = {
      "Shougo/ddu-source-file",
      "Shougo/ddu-column-filename",
      "Shougo/ddu.vim",
    },
    config = function()
      vim.keymap.set('n', ',q', function()
        vim.fn['ddu#start']({
          ui = 'filer',
          uiParams = {
            filer = {
              split = 'vertical',
              splitDirection = 'topleft',
              winWidth = 32,
            }
          },
          sources = { { name = 'file', params = {}, } },
          actionOptions = {
            narrow = {
              quit = false,
            },
          },
          sourceOptions = {
            _ = {
              columns = { 'filename' },
            },
          },
          kindOptions = {
            file = {
              defaultAction = 'open',
            },
          },
        })
      end)


      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-filer',
        callback = function(ev)
          vim.keymap.set('n', '<CR>', function()
            if vim.fn.line('.') == 1 then
              vim.fn['ddu#ui#filer#do_action']('itemAction', { name = 'narrow', params = { path = '..' } })
              return
            end


            local item = vim.fn['ddu#ui#get_item']()
            if (item['isTree']) then
              vim.fn['ddu#ui#filer#do_action']('itemAction', { name = 'narrow' } )
            else
              vim.fn['ddu#ui#filer#do_action']('itemAction', { name = 'open' })
            end
          end, { silent=true, buffer=true })

          vim.keymap.set('n', '<Space>', function()
            vim.fn['ddu#ui#filer#do_action']('toggleSelectItem')
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'o', function()
            vim.fn['ddu#ui#filer#do_action']('expandItem', { mode = 'toggle' })
          end, { silent=true, buffer=true })

          vim.keymap.set('n', 'q', function()
            vim.fn['ddu#ui#filer#do_action']('quit')
          end, { silent=true, buffer=true })
        end
      })

    end,
  }
}
