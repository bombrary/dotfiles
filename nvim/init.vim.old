filetype off
filetype plugin indent off

set t_Co=256           "screen が 256色"
set autoindent         "改行時に自動でインデントする
set splitright         "画面を縦分割する際に右に開く
set clipboard&
set clipboard^=unnamed
set hls                "検索した文字をハイライトする
set number             "行番号を表示
 
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set expandtab
set tabstop=2
set shiftwidth=2

tnoremap <Esc> <C-\><C-n>

"dein Scripts-----------------------------                                                          
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/bombrary/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/bombrary/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/bombrary/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
call dein#add('cocopon/iceberg.vim')
call dein#add('ulwlu/elly.vim')
call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})

let s:toml = '~/.config/nvim/dein.toml'
let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'
call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


colorscheme iceberg
set termguicolors


" Setting of access decorator on C++
set cindent
set cinoptions=g-1

" elm filetype setting
au BufNewFile,BufRead *.elm set expandtab tabstop=4 shiftwidth=4

let maplocalleader=" "

set completeopt=menuone

autocmd BufNewFile,BufRead *.plt  set filetype=gnuplot

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "purescript", "latex" }
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.asir = {
  install_info = {
    url = "~/repos/bombrary/tree-sitter-asir",
    files = {"src/parser.c"}
  },
  filetype = "rr"
}
EOF

function! SetLightTheme()
  colorscheme iceberg
  set background=light
  let g:lightline.colorscheme = 'iceberg'

  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! SetDarkTheme()
  colorscheme elly
  let g:lightline.colorscheme = 'elly'
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! -bar Termopen vsplit +terminal | echo &channel

command! SetLightTheme call SetLightTheme()
command! SetDarkTheme call SetDarkTheme()
