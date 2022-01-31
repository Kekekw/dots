local g = vim.g
local f = require("kekekw.functions")
local map = f.map

g["chadtree_settings"] = {
  ["options.show_hidden"] = true,
  ["options.session"] = false,
  ["view.sort_by"] = { "is_folder", "file_name", "ext" },
  ["keymap.tertiary"] = {"<C-t>"},
  ["keymap.v_split"] = {"<C-v>"},
  ["keymap.h_split"] = {"<C-x>"},
  ["keymap.collapse"] = {"za"},
  ["theme.icon_glyph_set"] = "ascii"
}

map("n", "<C-e>", "<CMD>CHADopen<CR>")
