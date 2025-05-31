local nvlsp = require "nvchad.configs.lspconfig"

local options = {
  server = {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
  },
}

return options
