return {
  "scalameta/nvim-metals",
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    -- Enable all necessary features
    metals_config.init_options.statusBarProvider = "on"
    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      enableSemanticHighlighting = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
      },
      scalafixConfigPath = ".scalafix.conf",
      serverVersion = "latest.snapshot",
    }

    -- Set up capabilities and on_attach function
    require("nvchad.mappings")
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, bufnr)
            -- Enable completion   -- Print LSP functions to check if they're available
        -- Use vim.schedule to ensure LSP is fully attached before setting up key mappings
        vim.schedule(function()
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Key mappings
            local map = vim.keymap.set
            local opts = { noremap = true, silent = true, buffer = bufnr }
            -- LSP mappings
            -- Metals specific mappings
            map("n", "<leader>mt", require("metals.tvp").toggle_tree_view, opts)
            map("n", "<leader>md", require("metals").implementation_location, opts)
            map("n", "<leader>mc", require("metals").compile_cascade, opts)
            map("n", "<leader>mi", require("metals").toggle_setting, opts)

            -- Debugging mappings
            map("n", "<leader>dc", require("dap").continue, opts)
            map("n", "<leader>dr", require("dap").repl.toggle, opts)
            map("n", "<leader>dK", require("dap.ui.widgets").hover, opts)
            map("n", "<leader>db", require("dap").toggle_breakpoint, opts)
            map("n", "<leader>dso", require("dap").step_over, opts)
            map("n", "<leader>dsi", require("dap").step_into, opts)
            map("n", "<leader>drl", require("dap").run_last, opts)

        end)
        -- Setup DAP for Scala
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
        require("metals").setup_dap()
    end

    return metals_config
  end,
  
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    -- Auto commands for file types
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })

    -- Debugging setup for Scala
    local dap = require("dap")
    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
          runType = "runOrTestFile",
          args = { "firstArg", "secondArg", "thirdArg" },
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = { runType = "testTarget" },
      },
    }
  end
}
