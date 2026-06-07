local function setup_terminal_colors()
  local COLORS = {
    "#626A96", -- black
    "#F7768E", -- red
    "#9ECE6A", -- green
    "#E5C890", -- yellow
    "#7AA2F7", -- blue
    "#BB9AF7", -- magenta
    "#7DCFFF", -- cyan
    "#A9B1D6", -- white
    "#414868", -- bright black
    "#F7768E", -- bright red
    "#9ECE6A", -- bright green
    "#E0AF68", -- bright yellow
    "#7AA2F7", -- bright blue
    "#BB9AF7", -- bright magenta
    "#7DCFFF", -- bright cyan
    "#C0CAF5", -- bright white
  }
  for i, color in ipairs(COLORS) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

local function setup_keymaps()
  -- Turn off neovide cursor animations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  -- scroll settings
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_scroll_animation_length = 0.10

  -- ⌘C, ⌘X, ⌘V
  vim.keymap.set("n", "<D-c>", '"+yy', { desc = "⌘C = Copy line to clipboard" })
  vim.keymap.set("v", "<D-c>", '"+y', { desc = "⌘C = Copy to clipboard" })
  vim.keymap.set("t", "<D-c>", '<C-\\><C-N>"+y', { desc = "⌘C = Copy to clipboard" })
  vim.keymap.set({ "n", "v", "t" }, "<D-x>", '<C-\\><C-N>"+d', { desc = "⌘X = Cut to clipboard" })
  vim.keymap.set({ "n", "v" }, "<D-v>", '"+p', { desc = "⌘V = Paste" })
  vim.keymap.set("i", "<D-v>", "<C-r>+", { desc = "⌘V = Paste" })
  vim.keymap.set("t", "<D-v>", '<C-\\><C-N>"+pi', { desc = "⌘V = Paste" })

  -- ⌘W
  vim.keymap.set({ "n", "t" }, "<D-w>", "<C-\\><C-N><cmd>bdelete<CR>", { desc = "⌘W = close buffer" })

  -- ⌘B - go to definition
  vim.keymap.set(
    { "n", "t" },
    "<D-b>",
    "<C-\\><C-N><cmd>lua vim.lsp.buf.definition()<CR>",
    { desc = "⌘B = go to definition" }
  )

  -- ⌘S
  vim.keymap.set({ "n", "i", "v", "t" }, "<D-s>", "<C-\\><C-N><cmd>silent w<CR>", {
    desc = "⌘S = save buffer",
  })

  -- ⌘T - Toggle terminal
  vim.keymap.set({ "n", "t" }, "<D-t>", function()
    local cfg = vim.api.nvim_win_get_config(0)
    if cfg.relative ~= "" or vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
    vim.cmd("ToggleTerm")
  end, { desc = "⌘T = Toggle terminal" })

  -- ⌘⇧C - Copy full filepath
  vim.keymap.set({ "n", "t" }, "<D-S-c>", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("Copied: " .. path)
  end, { desc = "⌘⇧C = Copy path of current buffer" })

  -- ⌘⇧[ and ⌘⇧] - Bufferline tab navigation
  vim.keymap.set({ "n", "t" }, "<D-{>", function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCyclePrev")
  end, { desc = "⌘⇧[ = Previous tab" })
  vim.keymap.set({ "n", "t" }, "<D-}>", function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCycleNext")
  end, { desc = "⌘⇧] = Next tab" })

  -- ⌘[ and ⌘] - Move buffer left/right in tab bar
  vim.keymap.set({ "n", "t" }, "<D-[>", function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineMovePrev")
  end, { desc = "⌘[ = Move buffer left" })
  vim.keymap.set({ "n", "t" }, "<D-]>", function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineMoveNext")
  end, { desc = "⌘] = Move buffer right" })

  -- ⌘3, ⌘R - Focus on Overseer, bring up OverseerRun menu
  vim.keymap.set({ "n", "t" }, "<D-3>", "<C-\\><C-N><cmd>OverseerToggle<CR>", { desc = "⌘3 = OverseerToggle" })
  vim.keymap.set({ "n", "t" }, "<D-r>", "<C-\\><C-N><cmd>OverseerRun<CR>", { desc = "⌘R = OverseerRun" })

  -- ⌘E - Focus on editor
  vim.keymap.set({ "n", "t" }, "<D-e>", function()
    local cfg = vim.api.nvim_win_get_config(0)
    if cfg.relative ~= "" or vim.bo.buftype == "terminal" then
      vim.cmd("wincmd p")
    end
  end, { desc = "⌘E = Return focus to editor" })

  -- ⌘A
  vim.keymap.set({ "n", "i", "v", "t" }, "<D-a>", "<C-\\><C-N>ggVG", { noremap = true, silent = true })

  -- ⌘/ - Comments toggled
  vim.keymap.set("n", "<D-/>", "gccj", { remap = true, desc = "⌘/ = Toggle comment and move down" })
  vim.keymap.set("v", "<D-/>", "gc", { remap = true, desc = "⌘/ = Toggle comment (visual)" })

  -- This uses the :Dashboard set in keymaps.lua
  vim.keymap.set({ "n", "t" }, "<D-H>", "<cmd>Dashboard<CR>", { desc = "⌘⇧H = Open Dashboard" })
end

return {
  {
    "akinsho/toggleterm.nvim",
    cond = function()
      return vim.g.neovide
    end,
    opts = {
      direction = "horizontal",
      shade_terminals = false,
      shading_factor = 30,
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            ignored = true,
            hidden = true,
          },
        },
      },
    },
    keys = {
      {
        -- ⌘1 - Toggle snacks explorer
        "<D-1>",
        function()
          Snacks.explorer()
        end,
        desc = "Toggle Explorer",
        mode = { "n", "t" },
      },
      {
        -- ⌘⇧J - Toggle snacks explorer, but because this already shows the current file in the explorer
        -- this is just to keep muscle memory static
        "<D-J>",
        function()
          Snacks.explorer()
        end,
        desc = "Toggle Explorer",
        mode = { "n", "t" },
      },
    },
  },

  {
    "neovide/neovide",
    cond = function()
      return vim.g.neovide
    end,
    lazy = false,
    init = function()
      vim.opt.guifont =
        "Maple Mono NF CN,Maple Mono NF,Liga SFMono Nerd Font,Hasklig,SF Mono,Menlo,Monaco,Courier New,monospace:h15"
      setup_terminal_colors()
      setup_keymaps()
    end,
  },
}
