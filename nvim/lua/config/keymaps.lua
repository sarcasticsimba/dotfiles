vim.api.nvim_create_user_command("Dashboard", function()
  vim.cmd("silent! %bd")
  require("snacks.dashboard").open()
end, {})

vim.keymap.set("n", "gg", "ggzz", { desc = "Go to line and center" })
vim.keymap.set({ "c" }, "<D-v>", "<C-r>+")
vim.keymap.set("n", "<D-P>", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin on current buffer" })

vim.keymap.set("n", "<leader>uu", function()
  local conf = vim.diagnostic.config()
  local enabled = conf.virtual_text
  if type(enabled) == "table" then
    enabled = enabled.enabled
  end
  vim.diagnostic.config({
    virtual_text = not enabled,
  })
end, { desc = "Toggle diagnostic inline text" })
