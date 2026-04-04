local augroup = vim.api.nvim_create_augroup("UserAutoGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group   = augroup,
  pattern = "*",
  callback = function()
    local skip = { "markdown", "diff", "gitcommit" }
    if vim.tbl_contains(skip, vim.bo.filetype) then return end
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group    = augroup,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

local extensions = {
  [".c"]   = { ".h" },
  [".cpp"] = { ".hpp", ".hxx", ".hh", ".h" },
  [".cxx"] = { ".hxx", ".hpp", ".hh", ".h" },
  [".cc"]  = { ".hh",  ".hpp", ".hxx", ".h" },
  [".h"]   = { ".c",   ".cpp", ".cxx", ".cc" },
  [".hpp"] = { ".cpp", ".cxx", ".cc" },
  [".hxx"] = { ".cxx", ".cpp", ".cc" },
  [".hh"]  = { ".cc",  ".cpp", ".cxx" },
}

vim.api.nvim_create_autocmd("BufReadPost", {
  group   = augroup,
  pattern = { "*.c", "*.cpp", "*.cxx", "*.cc", "*.h", "*.hpp", "*.hxx", "*.hh" },
  callback = function()
    if vim.fn.winnr("$") ~= 1 then return end
    local path = vim.api.nvim_buf_get_name(0)
    local stem, ext = path:match("^(.+)(%.%w+)$")
    if not stem or not extensions[ext] then return end
    for _, alt in ipairs(extensions[ext]) do
      local other = stem .. alt
      if vim.uv.fs_stat(other) then
        vim.schedule(function()
          vim.cmd("vsplit " .. vim.fn.fnameescape(other))
          vim.cmd("wincmd h")
        end)
        return
      end
    end
  end,
})
