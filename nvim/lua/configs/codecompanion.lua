local opts = {
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-3.7-sonnet",
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "copilot",
      slash_commands = {
        codebase = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
      },
      tools = {
        opts = {
          auto_submit_errors = true, -- Send any errors to the LLM automatically?
          auto_submit_success = true, -- Send any successful output to the LLM automatically?
        },
      },
    },
  },
  extensions = {
    vectorcode = {
      opts = {
        tool_group = {
          -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
          enabled = true,
          -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
          -- if you use @vectorcode_vectorise, it'll be very handy to include
          -- `file_search` here.
          extras = {},
          collapse = false, -- whether the individual tools should be shown in the chat
        },
        tool_opts = {
          ---@type VectorCode.CodeCompanion.ToolOpts
          ["*"] = {},
          ---@type VectorCode.CodeCompanion.LsToolOpts
          ls = {},
          ---@type VectorCode.CodeCompanion.VectoriseToolOpts
          vectorise = {},
          ---@type VectorCode.CodeCompanion.QueryToolOpts
          query = {
            max_num = { chunk = -1, document = -1 },
            default_num = { chunk = 50, document = 10 },
            include_stderr = false,
            use_lsp = true,
            no_duplicate = true,
            chunk_mode = false,
            ---@type VectorCode.CodeCompanion.SummariseOpts
            summarise = {
              ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
              enabled = false,
              adapter = nil,
              query_augmented = true,
            },
          },
          files_ls = {},
          files_rm = {},
        },
      },
    },
  },
}

return {
  opts = opts,
}
