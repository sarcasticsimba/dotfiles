return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },
  {
    "catppuccin/nvim",
    opts = function(_, opts)
      opts.integrations = opts.integrations or {}
      opts.integrations.lsp_semantic_tokens = true
    end,
  },
}
