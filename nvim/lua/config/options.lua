-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = ""
vim.opt.relativenumber = false
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
    },
  },
})
