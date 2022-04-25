local g = vim.g
local f = require("kekekw.functions")
local map = f.map

require("nvim-tree").setup {
    open_on_setup = true,
    view = {
        width = 70
    },
    filters = {
        dotfiles = true,
    }
}

map("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
map("n", "<leader>r", "<CMD>NvimTreeRefresh<CR>")
map("n", "<leader>n", "<CMD>NvimTreeFindFile<CR>")
