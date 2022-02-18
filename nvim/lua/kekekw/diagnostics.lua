local cmd = vim.cmd
local fn = vim.fn

local f = require("kekekw.functions")

local map = f.map


map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<cr>]])
map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<cr>]])
map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<cr>]])
map("n", "<leader>d", [[<cmd>lua vim.diagnostic.setloclist()<cr>]])
map("n", "<leader>nd", [[<cmd>lua vim.diagnostic.goto_next()<cr>]])
map("n", "<leader>pd", [[<cmd>lua vim.diagnostic.goto_prev()<cr>]])
map("n", "<leader>ld", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<cr>]])

fn.sign_define("DiagnosticsSignError", { text = "▬", texthl = "DiagnosticError" })
fn.sign_define("DiagnosticsSignWarn", { text = "▬", texthl = "DiagnosticWarn" })
fn.sign_define("DiagnosticsSignInfo", { text = "▬", texthl = "DiagnosticInfo" })
fn.sign_define("DiagnosticsSignHint", { text = "▬", texthl = "DiagnosticHint" })


-- vim.diagnostic.config({ virtual_text = false })



