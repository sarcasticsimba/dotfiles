return {
  "Davidyz/inlayhint-filler.nvim",
  keys = {
    {
      "<A-CR>",
      function()
        require("inlayhint-filler").fill()
      end,
      desc = "Fill inlay hint at cursor",
    },
  },
}
