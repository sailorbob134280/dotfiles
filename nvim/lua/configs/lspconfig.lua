-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
local util = require "lspconfig.util"

local servers = { "html", "cssls", "svelte", "ts_ls", "tailwindcss" }
local nvlsp = require "nvchad.configs.lspconfig"

-- merge blink capabilities with nvlsp capabilities
local capabilities = vim.tbl_deep_extend("force", nvlsp.capabilities, blink_capabilities)

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end

lspconfig.emmet_ls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "templ",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}

local c = require "configs.local_lspconfig"

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
  cmd = c.file_exists and c.custom_cmd or cmd,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
