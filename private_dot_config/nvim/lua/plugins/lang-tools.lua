return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        gopls = {},
        pyright = {},
        ruff = {},
        rust_analyzer = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "ruff",
        "tree-sitter-cli",
      },
    },
  },
}
