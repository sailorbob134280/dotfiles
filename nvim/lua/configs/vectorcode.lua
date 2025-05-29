local cacher = require "vectorcode.cacher.default"

local setup = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      cacher.async_check("config", function()
        cacher.register_buffer(bufnr, {
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
