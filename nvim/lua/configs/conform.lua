local options = {
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    css = { "prettier" },
    go = { "gofumpt", "goimports_reviser", "golines" },
    go_mod = { "gofumpt", "goimports_reviser", "golines" },
    go_work = { "gofumpt", "goimports_reviser", "golines" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "black" },
    rust = { "rustfmt" },
    svelte = { "prettier" },
    toml = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
