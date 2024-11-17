return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text", -- Fixed repository path
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
  },
  config = function()
    local dap_py = require("dap-python")
    local dap = require("dap")
    local dapui = require("dapui")
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    -- Basic debugpy setup
    dap_py.setup(path)
    -- Configure test runner
    dap_py.test_runner = "pytest"
    -- Enable virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
    })

    -- Configure UI
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.5 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
          },
          position = "left",
          size = 40
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10
        },
      },
    })

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Configure test discovery
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--verbose" },
          runner = "pytest",
        })
      }
    })

    -- Add python-specific configurations
    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Launch file with arguments",
      program = "${file}",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ")
      end,
    })

    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Launch file (with env vars)",
      program = "${file}",
      env = function()
        local env_string = vim.fn.input("Environment variables (KEY1=value1,KEY2=value2): ")
        local env_vars = {}
        for pair in env_string:gmatch("[^,]+") do
          local key, value = pair:match("([^=]+)=(.*)")
          if key and value then
            env_vars[key] = value
          end
        end
        return env_vars
      end,
    })

    -- Keymaps
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Debugging
    map("n", "<leader>pdb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>pdc", dap.continue, { desc = "Continue" })
    map("n", "<leader>pdr", dap_py.test_method, { desc = "Debug Test Method" })
    map("n", "<leader>pdm", function()
      dap_py.test_class()
    end, { desc = "Debug Test Class" })
    map("n", "<leader>pds", dap.step_over, { desc = "Step Over" })
    map("n", "<leader>pdi", dap.step_into, { desc = "Step Into" })
    map("n", "<leader>pdo", dap.step_out, { desc = "Step Out" })
    map("n", "<leader>pdC", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
    map("n", "<leader>pdp", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional Breakpoint" })

    -- UI controls
    map("n", "<leader>pdu", dapui.toggle, { desc = "Toggle UI" })
    map("n", "<leader>pdh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Hover Variables" })
    map("n", "<leader>pdf", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { desc = "Show Frames" })

    -- Test runner
    map("n", "<leader>ptt", function()
      require("neotest").run.run()
    end, { desc = "Run Nearest Test" })
    map("n", "<leader>ptf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run Test File" })
    map("n", "<leader>pts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle Test Summary" })
    map("n", "<leader>pto", function()
      require("neotest").output.open()
    end, { desc = "Show Test Output" })
  end,
}
