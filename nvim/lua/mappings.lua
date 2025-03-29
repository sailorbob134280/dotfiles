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

-- DAP
map({ "n", "v" }, "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "Add breakpoint at line" })
map({ "n" }, "<leader>dr", "<cmd> DapContinue <cr>", { desc = "Start or continue the debugger" })
map({ "n" }, "<leader>dus", function ()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })

-- DAP Go
map({ "n" }, "<leader>dgt", function ()
  require("dap-go").debug_test()
end, { desc = "Debug go test" })
map({ "n" }, "<leader>dgl", function ()
  require("dap-go").debug_last()
end, { desc = "Debug last go test" })

-- Gopher
map({ "n" }, "<leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add JSON struct tags" })
map({ "n" }, "<leader>gsy", "<cmd> GoTagAdd yaml <CR>", { desc = "Add YAML struct tags" })

-- DAP Python
map({ "n" }, "<leader>dpr", function ()
  require('dap-python').test_method()
end, { desc = "Debug Python test" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
