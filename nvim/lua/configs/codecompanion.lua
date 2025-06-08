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
          auto_submit_errors = true,  -- Send any errors to the LLM automatically?
          auto_submit_success = true, -- Send any successful output to the LLM automatically?
        },
        vectorcode = {
          description = "Run VectorCode to retrieve the project context.",
          callback = require("vectorcode.integrations").codecompanion.chat.make_tool(),
        },
      },
    },
  },
}

return {
  opts = opts,
}
