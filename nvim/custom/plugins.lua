local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "MunifTanjim/prettier.nvim",
    lazy = false,
    config = function ()
      require("prettier").setup({
        bin = "prettierd",
        cli_options = {
          html_whitespace_sensitivity = "css",
        },
      })
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "golines",
        "goimports-reviser",
        "gofumpt",
        "gotests",
        "gomodifytags",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "clangd",
        "clang-format",
        "codelldb",
        "prettierd",
        "typescript-language-server",
        "svelte-language-server",
        "tailwindcss-language-server",
        "emmet-ls",
        "lua-language-server",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function ()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap-go")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    }
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"go", "python"},
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function (_, opts)
      require("gopher").setup(opts)
    end,
    build = function ()
      vim.cmd [[silent! GoInstallDeps]]
      require("core.utils").load_mappings("gopher")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = function ()
      return require "custom.configs.copilot"
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end
  },
  {
    "NoahTheDuke/vim-just",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "\\cjustfile", "*.just", ".justfile" },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    opts = require("custom.configs.oil-config"),
    config = function(_, opts)
      require('oil').setup(opts)
    end,
    keys = {
      {"-", "<Cmd>Oil<CR>", mode = "n", desc = "Open parent directory" },
      {"<space>-", "<Cmd>Oil --float<CR>", mode = "n", desc = "Open parent directory in floating window" },
    },
    -- Cannot be lazy loaded because otherwise it won't open
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
}

return plugins
