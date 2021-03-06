require("nvim-treesitter.configs").setup({
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  -- ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "scala" },
  }
})
