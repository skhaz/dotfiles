local augroup = vim.api.nvim_create_augroup("LspGroup", { clear = true })

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas  = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas     = require("schemastore").yaml.schemas(),
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
    end
    map("gd",         vim.lsp.buf.definition,  "Go to definition")
    map("K",          vim.lsp.buf.hover,        "Hover documentation")
    map("gr",         vim.lsp.buf.references,   "Find references")
    map("<leader>rn", vim.lsp.buf.rename,       "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action,  "Code action")
  end,
})
