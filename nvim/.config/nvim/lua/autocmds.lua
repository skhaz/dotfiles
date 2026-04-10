local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if vim.tbl_contains({ "markdown", "diff", "gitcommit" }, vim.bo.filetype) then return end
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

