local opt = vim.opt

opt.autoindent = true
opt.splitright = true
opt.hls = true
opt.number = true
opt.whichwrap = 'b', 's', 'h', 'l', '<', '>', '[', ']'
opt.cursorline=true
opt.expandtab=true
opt.tabstop=2
opt.shiftwidth=2
opt.helplang = 'ja', 'en'
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.showmatch = true
opt.clipboard:append({unnamedplus = true})
opt.list = true
opt.listchars = {tab = '>-', trail = '*', nbsp = '+', eol = '↲', extends = '»', precedes = '«'}


local dein_base = '/home/bombrary/.cache/dein'
local dein_src = '/home/bombrary/.cache/dein/repos/github.com/Shougo/dein.vim'
opt.runtimepath:prepend(dein_src)

local dein = require('dein')
dein.setup {
  auto_remote_plugins = false,
  enable_notification = true,
}

dein.begin(dein_base)

dein.add('Shougo/dein.vim', { on_ft = {'vim'} })

dein.load_toml('/home/bombrary/.config/nvim/dein.toml', { lazy=false })
dein.load_toml('/home/bombrary/.config/nvim/dein_lazy.toml', { lazy=true })

dein.add('sainnhe/everforest')

dein.end_()

if dein.check_install() then
  dein.install()
end


vim.cmd.colorscheme('everforest')
