-- leader & globals
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options
local o = vim.opt

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = false
o.scrolloff = 8

o.splitbelow = true
o.splitright = true

o.ignorecase = true
o.smartcase = true

o.autoread = true
o.undofile = true
o.updatetime = 250
o.clipboard = "unnamedplus"
o.mouse = "a"

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- autocmds
local user_augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = user_augroup,
  callback = function()
    if vim.tbl_contains({ "markdown", "diff", "gitcommit" }, vim.bo.filetype) then return end
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = user_augroup,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local api = require("nvim-tree.api")
      require("nvim-tree").setup({
        view = { side = "right" },
        renderer = {
          icons = {
            show = { file = false, folder = false, folder_arrow = false, git = false },
          },
        },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "<C-t>", api.tree.toggle, { buffer = bufnr })
        end,
      })
      vim.keymap.set("n", "<C-t>", api.tree.toggle)
    end,
  },

  { "williamboman/mason.nvim", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "clangd", "lua_ls", "pyright", "ts_ls",
        "gopls", "bashls", "jsonls", "yamlls", "marksman",
      },
      automatic_enable = true,
    },
  },

  { "b0o/schemastore.nvim", lazy = true },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "neovim/nvim-lspconfig" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = { { name = "nvim_lsp" } },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }),
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local rg = {
        "rg", "--color=never", "--no-heading", "--with-filename",
        "--line-number", "--column", "--smart-case", "--max-columns=0",
      }

      require("telescope").setup({
        defaults = {
          vimgrep_arguments = vim.list_extend(vim.deepcopy(rg), { "--fixed-strings" }),
          file_ignore_patterns = { "%.git/" },
        },
      })

      local b = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", function() b.find_files({ hidden = true }) end)
      vim.keymap.set("n", "<C-g>", b.live_grep)
      vim.keymap.set("n", "<C-r>", function() b.live_grep({ vimgrep_arguments = rg }) end)
      vim.keymap.set("n", "<leader>fb", b.buffers)
      vim.keymap.set("n", "<leader>fh", b.help_tags)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()

      local wanted = { "cpp", "typescript", "python", "lua", "json", "yaml", "markdown", "markdown_inline" }
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(l) return not vim.list_contains(installed, l) end, wanted)
      if #missing > 0 then ts.install(missing) end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },
    },
  },
})

-- lsp
vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
  callback = function(args)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("gr", vim.lsp.buf.references, "Find references")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
  end,
})
