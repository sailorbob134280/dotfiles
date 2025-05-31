require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- TMUX nav
map("n", "<C-h>", "<cmd> TmuxNavigateLeft <cr>", { desc = "Navigate to left pane in tmux" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight <cr>", { desc = "Navigate to right pane in tmux" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown <cr>", { desc = "Navigate to bottom pane in tmux" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp <cr>", { desc = "Navigate to top pane in tmux" })

-- LSP
map("n", "<leader>ca", "<cmd> lua vim.lsp.buf.code_action() <cr>", { desc = "Code action" })

-- Refactoring
map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")
map("x", "<leader>rv", ":Refactor extract_var ")
map({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
map("n", "<leader>rI", ":Refactor inline_func")
map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- DAP
map({ "n", "v" }, "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "Add breakpoint at line" })
map({ "n" }, "<leader>dr", "<cmd> DapContinue <cr>", { desc = "Start or continue the debugger" })
map({ "n" }, "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })
map({ "n" }, "<leader>dui", function()
  require("dapui").toggle()
end, { desc = "Open debugger view" })

-- DAP Go
map({ "n" }, "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "Debug go test" })
map({ "n" }, "<leader>dgl", function()
  require("dap-go").debug_last()
end, { desc = "Debug last go test" })

-- Gopher
map({ "n" }, "<leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add JSON struct tags" })
map({ "n" }, "<leader>gsy", "<cmd> GoTagAdd yaml <CR>", { desc = "Add YAML struct tags" })
map({ "n" }, "<leader>gcm", "<cmd> GoCmt <CR>", { desc = "Add doc comment" })
map({ "n" }, "<leader>ger", "<cmd> GoIfErr <CR>", { desc = "Add error handling boilerplate" })

-- Rust
map({ "n" }, "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, { desc = "Upgrade all crates" })

-- DAP Python
map({ "n" }, "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "Debug Python test" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
