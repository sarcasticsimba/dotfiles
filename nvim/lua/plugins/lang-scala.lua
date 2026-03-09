return {
  -- Be sure to brew install coursier, then cs install metals
  -- Mostly adapted from https://github.com/scalameta/nvim-metals/discussions/39
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
      }

      -- Required: enables LSP progress via fidget.nvim (which LazyVim has)
      metals_config.init_options.statusBarProvider = "off"

      -- uncomment if adding the nvim-cmp extra later
      -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals_config.on_attach = function(client, bufnr)
        -- Metals DAP setup requires dap.core extra
        require("metals").setup_dap()
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = group,
      })
    end,
  },
}
