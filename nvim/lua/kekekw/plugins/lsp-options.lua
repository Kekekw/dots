local cmd = vim.cmd
local f = require("kekekw.functions")
local map = f.map
local util = require 'lspconfig/util'

local lsp_config = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true 

lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
})
lsp_config.jsonls.setup {
  capabiltities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas()
    }
  }
}

lsp_config.terraformls.setup{}
lsp_config.vuels.setup{}
lsp_config.pyright.setup{}

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
  require("metals").setup_dap()
  --cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.hover()]])
  cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
  cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  cmd([[autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()]])
  
  cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
  cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
  cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
end

cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt,java lua require("metals").initialize_or_attach(metals_config)]])

cmd([[hi! link LspReferenceText CursorColumn]])
cmd([[hi! link LspReferenceRead CursorColumn]])
cmd([[hi! link LspReferenceWrite CursorColumn]])

local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run",
    metals = {
      runType = "run",
    }
  },
  {
    type = "scala",
    request = "launch",
    name = "Test",
    metals = {
      runType = "test"
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

lsp_config.tsserver.setup {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.hover()]])
    cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])

    ts_utils.setup {
      debug = true 
    }
    ts_utils.setup_client(client)
  end
}

lsp_config.diagnosticls.setup{
  filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslintrc.js",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}

local signature_help_config = {
  bind = true,
  hhandler_opts = {
    border = "rounded"
  }
}
require("lsp_signature").setup(signature_help_config)


map("n", "<leader>dc", [[<cmd>lua require("dap").continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require("dap").repl.toggle()<CR>]])
map(
  "n",
  "<leader>ds",
  [[<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).toggle()<CR>]]
)
map("n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
map("n", "<leader>dtl", [[<cmd>lua require("dap").list_breakpoints()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require("dap").run_last()<CR>]])

map("n", "gD", [[<cmd>lua vim.lsp.buf.declaration()<CR>]])
map("n", "gd", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
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
