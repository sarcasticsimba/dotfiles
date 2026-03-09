local header = table.concat(vim.fn.readfile(vim.fs.joinpath(vim.fn.stdpath("config"), "ascii-header.txt")), "\n")

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = header,
        },
      },
    },
  },
}
