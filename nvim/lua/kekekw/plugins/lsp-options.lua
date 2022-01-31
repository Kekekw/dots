local cmd = vim.cmd
local f = require("kekekw.functions")
local map = f.map


local lsp_config = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
})

metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl",
    "akka.stream.javadsl",
  },
  fallbackScalaVersion = "2.13.7",
}
metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

metals_config.on_attach = function(client, buffer)
  cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
  cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
  cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
end

cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt,java lua require("metals").initialize_or_attach(metals_config)]])

local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    }
  },
  {
    type = "scala",
    request = "launch",
    name = "Test target",
    metals = {
      runType = "testTarget",
    }
  }
}


map("n", "<leader>dc", [[<cmd>lua require("dap").continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require("dap").repl.toggle()<CR>]])
map(
  "n",
  "<leader>ds",
  [[<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).toggle()<CR>]]
)
map("n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require("dap").run_last()<CR>]])

map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map("n", "<leader>ws", [[<cmd>lua require("metals").hover_worksheet()<CR>]])
map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map("n", "<leader>o", [[<cmd>lua vim.lsp.buf.formatting()<CR>]])
map("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])
