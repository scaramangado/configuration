vim.g.mapleader = " "

-- Reload Config
vim.keymap.set("n", "<F5>", "<cmd>source $MYVIMRC<CR><cmd>echo '--Refreshed config--'<CR>")
vim.keymap.set("i", "<F5>", "<ESC><cmd>source $MYVIMRC<CR><cmd>echo '--Refreshed config--'<CR>==gi")
vim.keymap.set("v", "<F5>", "<ESC><cmd>source $MYVIMRC<CR><cmd>echo '--Refreshed config--'<CR>gv=gv")

-- Disable arrow keys
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("v", "<Left>", "<nop>")
vim.keymap.set("v", "<Right>", "<nop>")
vim.keymap.set("v", "<Up>", "<nop>")
vim.keymap.set("v", "<Down>", "<nop>")

-- Mode Switching
vim.keymap.set("n", "<C-Space>", "i")
vim.keymap.set("i", "<C-Space>", "<Esc>l")
vim.keymap.set("c", "<C-Space>", "<Esc>")

-- Move current line
vim.keymap.set("n", "<A-S-Down>", "<cmd>m .+1<CR>==")
vim.keymap.set("n", "<A-S-Up>", "<cmd>m .-2<CR>==")
vim.keymap.set("i", "<A-S-Down>", "<Esc><cmd>m .+1<CR>==gi")
vim.keymap.set("i", "<A-S-Up>", "<Esc><cmd>m .-2<CR>==gi")
vim.keymap.set("v", "<A-S-Down>", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-S-Up>", "<cmd>m '<-2<CR>gv=gv")

-- Delete current line
vim.keymap.set("n", "<C-y>", "dd")
vim.keymap.set("i", "<C-y>", "<ESC>dd==gi")

-- Splits
vim.keymap.set("n", "<leader>w", "<C-w>")

-- NERDTree
vim.keymap.set("n", "<A-1>", "<cmd>NERDTreeToggle<CR>")

