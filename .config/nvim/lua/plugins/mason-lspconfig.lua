return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "golangci_lint_ls" },
      automatic_installation = true,
    },
  },
}
