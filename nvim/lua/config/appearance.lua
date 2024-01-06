vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("colorscheme_override", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#123234" })
  end,
})
