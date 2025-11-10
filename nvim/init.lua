-- Set leader key (optional but recommended)
vim.g.mapleader = " "

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.scrolloff = 10 -- Scroll Offset from top/bottom
vim.o.clipboard = "unnamedplus" -- OS shared clipboard

require("config.lazy")

-- Basic Neovim settings (optional)
vim.opt.number = true
vim.opt.relativenumber = true

