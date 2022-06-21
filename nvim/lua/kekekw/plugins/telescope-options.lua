local f = require("kekekw.functions")
local map = f.map

local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { ".idea", ".metals", ".git", ".bloop", "target", "node_modules", "parser.c", "out", "%.min.js" },
    prompt_prefix = "> ",
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {
        ["f"] = actions.send_to_qflist,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    },

  },
  pickers = {
    find_files = {
      hidden = true
    }
  },
})
require("telescope").load_extension("fzy_native")

map("n", "<leader>ff", [[<cmd>lua require("telescope.builtin").find_files({layout_strategy="vertical"})<CR>]])
map("n", "<leader>lg", [[<cmd>lua require("telescope.builtin").live_grep({layout_strategy="vertical"})<CR>]])
map("n", "<leader>gh", [[<cmd>lua require("telescope.builtin").git_commits({layout_strategy="vertical"})<CR>]])
map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
map("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").buffers()<CR>]])
map("n", "gds", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>]])
