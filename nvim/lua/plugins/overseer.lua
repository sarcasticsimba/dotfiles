return {
  {
    "stevearc/overseer.nvim",
    opts = function()
      local constants = require("overseer.constants")
      local TAG = constants.TAG

      local function find_project_root(starting_dir)
        local markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }
        local dir = starting_dir
        while dir ~= "/" do
          for _, marker in ipairs(markers) do
            if vim.fn.isdirectory(dir .. "/" .. marker) == 1 or vim.fn.filereadable(dir .. "/" .. marker) == 1 then
              return dir
            end
          end
          dir = vim.fn.fnamemodify(dir, ":h")
        end
        return starting_dir
      end

      local function save_all_buffers()
        vim.cmd("wa")
      end

      local function get_python_test_location()
        local buf = vim.api.nvim_get_current_buf()

        local ok, _ = pcall(vim.treesitter.start, buf, "python")
        if not ok then
          return nil, nil
        end

        local node = vim.treesitter.get_node()
        if not node then
          return nil, nil
        end

        local class_name, method_name
        local current = node

        while current do
          local node_type = current:type()

          if node_type == "function_definition" then
            local name_field = current:field("name")[1]
            if name_field then
              method_name = vim.treesitter.get_node_text(name_field, buf)
            end
          elseif node_type == "class_definition" then
            local name_field = current:field("name")[1]
            if name_field then
              class_name = vim.treesitter.get_node_text(name_field, buf)
            else
              local child = current:child(0)
              if child and child:type() == "identifier" then
                class_name = vim.treesitter.get_node_text(child, buf)
              end
            end
          end

          current = current:parent()
        end

        if method_name and not method_name:match("^test") then
          method_name = nil
        end

        return class_name, method_name
      end

      local templates = {
        {
          name = "Python unittest (current file)",
          builder = function()
            save_all_buffers()
            local file = vim.fn.expand("%:p")
            return {
              cmd = { "uv", "run", "python", "-m", "unittest" },
              args = { file },
              components = { "default" },
            }
          end,
          condition = { filetype = { "python" } },
          tags = { TAG.TEST },
        },
        {
          name = "Python unittest (smart)",
          builder = function()
            save_all_buffers()
            local file = vim.fn.expand("%:p")
            local class_name, method_name = get_python_test_location()

            if class_name then
              -- Find project root and calculate module path
              local file_dir = vim.fn.fnamemodify(file, ":p:h")
              local project_root = find_project_root(file_dir)
              local rel_path = vim.fn.fnamemodify(file, ":.")
              local module = rel_path:gsub("/", "."):gsub("%.py$", "")

              local test_spec = class_name
              if method_name then
                test_spec = class_name .. "." .. method_name
              end

              return {
                cmd = { "uv", "run", "python", "-m", "unittest" },
                args = { module .. "." .. test_spec },
                cwd = project_root,
                components = { "default" },
              }
            end

            return {
              cmd = { "uv", "run", "python", "-m", "unittest" },
              args = { file },
              components = { "default" },
            }
          end,
          condition = { filetype = { "python" } },
          tags = { TAG.TEST },
        },

        {
          name = "go run .",
          builder = function()
            save_all_buffers()
            return {
              cmd = { "go", "run", "." },
              components = { "default" },
            }
          end,
          condition = { filetype = { "go" } },
        },
      }

      vim.defer_fn(function()
        local overseer = require("overseer")
        for _, template in ipairs(templates) do
          overseer.register_template(template)
        end
      end, 100)

      return {
        templates = { "builtin", "user" },
        task_list = {
          keymaps = {
            ["<C-j>"] = false,
            ["<C-k>"] = false,
          },
        },
        form = {
          win_opts = {
            winblend = 0,
          },
        },
        task_win = {
          win_opts = {
            winblend = 0,
          },
        },
      }
    end,
  },
}
