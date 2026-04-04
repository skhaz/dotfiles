local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local ripgrep = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--max-columns=0", "--fixed-strings" }

local augroup = vim.api.nvim_create_augroup("PluginsGroup", { clear = true })

require("lazy").setup({

  {
    "AlexvZyl/nordic.nvim",
    lazy     = false,
    priority = 1000,
    config = function()
      require("nordic").setup({})
      vim.cmd.colorscheme("nordic")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local api = require("nvim-tree.api")
      require("nvim-tree").setup({
        view     = { side = "right" },
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
        "gopls",  "bashls", "jsonls",  "yamlls", "marksman",
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
          ["<CR>"]  = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }),
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments    = ripgrep,
          file_ignore_patterns = { "%.git/" },
        },
      })
      local b = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>",       function() b.find_files({ hidden = true }) end)
      vim.keymap.set("n", "<C-g>",       b.live_grep)
      vim.keymap.set("n", "<C-r>",       function() b.live_grep({ vimgrep_arguments = vim.tbl_filter(function(a) return a ~= "--fixed-strings" end, ripgrep) }) end)
      vim.keymap.set("n", "<leader>fb",  b.buffers)
      vim.keymap.set("n", "<leader>fh",  b.help_tags)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy  = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      local wanted   = { "cpp", "typescript", "python", "lua", "json", "yaml", "markdown", "markdown_inline" }
      local installed = require("nvim-treesitter").get_installed()
      local missing   = vim.tbl_filter(function(l) return not vim.list_contains(installed, l) end, wanted)
      if #missing > 0 then require("nvim-treesitter").install(missing) end
      vim.api.nvim_create_autocmd("FileType", {
        group    = augroup,
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "-" },
        topdelete    = { text = "-" },
        changedelete = { text = "~" },
        untracked    = { text = "?" },
      },
    },
  },
})
