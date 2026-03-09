return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")
      elixir.setup({
        nextls = { enable = false },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = true,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>cp", ":ElixirToPipe<cr>", { buffer = true, desc = "To Pipe" })
            vim.keymap.set("n", "<leader>cP", ":ElixirFromPipe<cr>", { buffer = true, desc = "From Pipe" })
            vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", { buffer = true, desc = "Expand Macro" })
          end,
        },
        projectionist = { enable = true },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.elixirls = nil
    end,
  },
}
