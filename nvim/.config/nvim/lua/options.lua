vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.opt

-- indentation
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

-- ui
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true
o.scrolloff = 8

-- splits
o.splitbelow = true
o.splitright = true

-- search
o.ignorecase = true
o.smartcase = true

-- misc
o.autoread = true
o.undofile = true
o.updatetime = 250
o.clipboard = "unnamedplus"
o.mouse = "a"

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
