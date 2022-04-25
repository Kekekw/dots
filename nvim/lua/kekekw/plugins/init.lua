require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" }
    }
  })

  -- use({ "kyazdani42/nvim-web-devicons" })
  -- use('glepnir/lspsaga.nvim')
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" }
    }
  })
  use({ "ray-x/lsp_signature.nvim"})
  use({ "neovim/nvim-lspconfig" })
  use({ "tpope/vim-vinegar" })
  use({ "sheerun/vim-polyglot" })
  use({ "ckipp01/nvim-jvmopts" })
  use({ "tpope/vim-fugitive" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "nvim-treesitter/playground" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "rebelot/kanagawa.nvim" })
  use({ "folke/tokyonight.nvim"  })
  use ({
    "scalameta/nvim-metals",
    requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" }
  })
  use({ "ms-jpq/chadtree", branch = chad, run = "python3 -m chadtree deps", requires = "kyazdani42/nvim-web-devicons"})
  use({ "907th/vim-auto-save" })
  use({ "glepnir/galaxyline.nvim" })
  use({ "windwp/nvim-autopairs"})

  use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
  use({ "b0o/schemastore.nvim" })
  use({ "sbdchd/neoformat" })
  use({"fatih/vim-go"})
  -- use({ "kyazdani42/nvim-tree.lua",
  --  requires = {
  --   "kyazdani42/nvim-web-devicons"
  --  },
  -- })
  use({ "hashicorp/terraform-ls" })
end)

require("nvim-autopairs").setup()
-- require("kekekw.plugins.devicons-options")
-- require("lspsaga").init_lsp_saga()
require("kekekw.plugins.blankline-options")
require("kekekw.plugins.telescope-options")
require("kekekw.plugins.chad-options")
-- require("kekekw.plugins.nvim-tree-options")
require("kekekw.plugins.lsp-options")
require("kekekw.plugins.cmp-options")
require("kekekw.plugins.treesitter-options")
require("kekekw.plugins.autosave-options")
