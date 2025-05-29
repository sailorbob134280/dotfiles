local opts = {
  keymap = {
    preset = "enter",
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-Tab>"] = { "snippet_forward", "fallback" },
    ["<C-S-Tab>"] = { "snippet_backward", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-k>"] = { "show_signature", "hide_signature", "show_documentation", "hide_documentation", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
  },
  fuzzy = { implementation = "rust" },
  snippets = {
    preset = "luasnip",
  },
  signature = {
    enabled = true,
  },
  completion = {
    list = {
      selection = {
        preselect = false,
      },
    },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod", "emoji", "dictionary", "codecompanion" },
    providers = {
      lsp = {
        name = "lsp",
        enabled = true,
        module = "blink.cmp.sources.lsp",
        score_offset = 100,
      },
      snippets = {
        name = "snippets",
        enabled = true,
        module = "blink.cmp.sources.snippets",
        score_offset = 90,
      },
      lazydev = {
        name = "lazydev",
        module = "lazydev.integrations.blink",
        score_offset = 90,
      },
      codecompanion = {
        name = "CodeCompanion",
        module = "codecompanion.providers.completion.blink",
        enabled = true,
        score_offset = 100,
      },
      dadbod = {
        name = "dadbod",
        module = "vim_dadbod_completion.blink",
        enabled = true,
        score_offset = 100,
      },
      emoji = {
        name = "emoji",
        module = "blink-emoji",
        enabled = true,
        score_offset = 30,
      },
      dictionary = {
        name = "Dict",
        module = "blink-cmp-dictionary",
        enabled = true,
        max_items = 8,
        min_keyword_length = 3,
        score_offset = 20,
      },
    },
  },
}

return {
  opts = opts,
}
