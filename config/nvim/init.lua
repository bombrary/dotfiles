vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.hls = true
vim.opt.number = true
vim.opt.whichwrap = 'b', 's', 'h', 'l', '<', '>', '[', ']'
vim.opt.cursorline=true
vim.opt.expandtab=true
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.helplang = 'ja', 'en'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.clipboard:append{'unnamedplus'}
vim.opt.list = true
vim.opt.listchars = {tab = '>-', trail = '*', nbsp = '+', eol = '↲', extends = '»', precedes = '«'}
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.lazy")
