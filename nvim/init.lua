-- Kekekw dotfiles for nvim
--
-- Enables a lot of good stuff to work

if require("kekekw.pre")() then
	return
end

local cmd = vim.cmd
local g = vim.g

g["mapleader"] = " "

local f = require("kekekw.functions")
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

require("kekekw.plugins")
require("kekekw.status")
require("kekekw.globals")
require("kekekw.diagnostics")

g["netrw_gx"] = "<cWORD>"
g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

local indent = 2

global_opt.shortmess:remove("F"):append("c")
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 300
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.clipboard = "unnamed"
global_opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5

opt.wrap = false
opt.cursorline = true
opt.number = true
opt.signcolumn = "yes"
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.fileformat = "unix"
opt.statusline = "%!luaeval('Super_custom_status_line()')"

map("i", "jj", "<ESC>")
map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")

map("n", "<leader>xml", ":%!xmllint --format -<cr>")

map("n", "<leader>slc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_line()<CR>]])
map("n", "<leader>sc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_input()<CR>]])

cmd("colorscheme kanagawa")
local kanagawa_colors = require("kanagawa.colors").setup()
cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.fujiGray, kanagawa_colors.sumiInk1))
cmd([[hi! link StatusLineNC Comment]])
cmd([[hi! link StatusError DiagnosticError]])
cmd([[hi! link StatusWarn DiagnosticWarn]])

cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank {}]])


