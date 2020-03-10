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

let maplocalleader=" "

if &compatible
  set nocompatible
endif

" dein settings 
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"git clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/.config/nvim/dein.toml'
  let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


filetype plugin indent on
syntax enable

" Setting of access decorator on C++
set cindent
set cinoptions=g-1
