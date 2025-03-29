return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "cue",
        "dockerfile",
        "go",
        "hcl",
        "helm",
        "html",
        "javascript",
        "jinja",
        "json",
        "just",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "meson",
        "ninja",
        "proto",
        "python",
        "rust",
        "scss",
        "sql",
        "svelte",
        "templ",
        "toml",
        "typescript",
  			"vim",
        "vimdoc",
        "yaml",
  		},
  	},
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "configs.lspconfig"
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
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Mason must be loaded first
    },
    cmd = {
      "MasonToolsInstall", "MasonToolsInstallSync",
      "MasonToolsUpdate", "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
    opts = {
      ensure_installed = {
        "air",
        "black",
        "clang-format",
        "clangd",
        "cmake-language-server",
        "codelldb",
        "cucumber-language-server",
        "cuelsp",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "emmet-ls",
        "go-debug-adapter",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golangci-lint-langserver",
        "golines",
        "gomodifytags",
        "gopls",
        "gotests",
        "iferr",
        "impl",
        "lua-language-server",
        "markdownlint",
        "mesonlsp",
        "mypy",
        "prettier",
        "prettierd",
        "protolint",
        "pyright",
        "ruff",
        "svelte-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    -- init = function ()
      -- require("nvchad.utils").load_mappings("dap")
    -- end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
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
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    opts = {
      sources = {

        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",

            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
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
      return require "configs.null-ls"
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
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = function ()
      return require "configs.copilot"
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
    opts = require("configs.oil-config"),
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
