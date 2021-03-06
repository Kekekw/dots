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
require("kekekw.globals")
require("kekekw.diagnostics")
require("kekekw.plugins.galaxyline").setup()


g["netrw_gx"] = "<cWORD>"
g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

local indent = 2

global_opt.shortmess:remove("F"):append("c")
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 500
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
opt.relativenumber = true
opt.signcolumn = "yes"
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.fileformat = "unix"
opt.list = true
opt.listchars:append("eol:↴")
opt.listchars:append("space:⋅")
--require("lspsaga").init_lsp_saga({
--	finder_action_keys = { open = '<CR>', vsplit = 's', split = 'i', quit = 'q' },
--	server_filetype_map = { metals = { 'sbt', 'scala' }}
--})


map("i", "jj", "<ESC>")
map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")

map("n", "<C-Up>", ":wincmd k<cr>")
map("n", "<C-Down>", ":wincmd j<cr>")
map("n", "<C-Left>", ":wincmd h<cr>")
map("n", "<C-Right>", ":wincmd l<cr>")
map('n', '<C-k>', ':wincmd k<CR>')
map('n', '<C-j>', ':wincmd j<CR>')
map('n', '<C-h>', ':wincmd h<CR>')
map('n', '<C-l>', ':wincmd l<CR>')

map("n", "<leader>xml", ":%!xmllint --format -<cr>")

--cmd("colorscheme kanagawa")
cmd("colorscheme tokyonight")
local kanagawa_colors = require("kanagawa.colors").setup()
cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.fujiGray, kanagawa_colors.sumiInk1))
cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank {}]])


