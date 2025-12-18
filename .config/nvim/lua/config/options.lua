local opt = vim.opt

-- General
opt.compatible = false
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.number = true
opt.cursorline = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.wrap = true
opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- UI
opt.showtabline = 2
opt.showmode = false
opt.laststatus = 2

-- Files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autowrite = false
vim.opt.autoread = true

-- Spell check
vim.opt_local.spell = false
vim.opt_local.spelllang = { "en", "fr" }

-- :checkhealth
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
