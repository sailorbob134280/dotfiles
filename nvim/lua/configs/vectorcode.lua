local utils = require("vectorcode.cacher").utils
local default = require("vectorcode.cacher.default")

local setup = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      utils.async_check("config", function()
        default.register_buffer(bufnr, {
          n_query = 10,
        })
      end, nil)
    end,
    desc = "Register buffer for VectorCode",
  })
end

return {
  setup = setup,
}
