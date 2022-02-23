local f = require("kekekw.functions")
local map = f.map
local lsp_saga = require("lspsaga")

lsp_saga.init_lsp_saga({
    code_action_prompt = {
      virtual_text = false,
    },
  })

map("n", "<leader>ca", [[<cmd>lua require("lspsaga.codeaction").code_action()<CR>]])
map("v", "<leader>ca", [[<cmd>lua require("lspsaga.codeaction").range_code_action()<CR>]])

