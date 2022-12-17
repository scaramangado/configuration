local base = require("base")
base.requireIfExists("private")
base.requireIfExists("work")

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.showmode = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.mouse = "a"

vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"

vim.opt.encoding = "utf-8"

