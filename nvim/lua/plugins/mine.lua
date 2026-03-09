return {
  { "folke/flash.nvim", enabled = false },
  { "nvim-mini/mini.nvim", version = "*" },
  { "neovim/nvim-lspconfig" },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          enabled = false, -- Disable LSP progress notifications
        },
      },
    },
  },

  {
    "goldos24/rainbow-variables-nvim",
    config = function()
      require("rainbow-variables-nvim").start_with_config({
        reduce_color_collisions = true,
        semantic_background_colors = false,
        palette = {
          "#C0A5F8",
          "#9381F9",
          "#B6ABF4",
          "#A1A2ED",
          "#77BDD3",
          "#97D7E3",
          "#6BBBD6",
          "#DE84BE",
          "#E8A4CE",
          "#E07BBE",
          "#86BDE8",
          "#BCD09C",
          "#BEE0A1",
          "#F8C48F",
          "#FFD4AF",
          "#F9D87C",
        },
      })
    end,
  },
}
