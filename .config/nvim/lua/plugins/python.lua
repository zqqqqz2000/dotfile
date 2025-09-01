return {
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
      "nvim-dap",
    },
    opts = function(_, opts)
      if require("lazyvim.util").has("nvim-dap-python") then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "black", "isort" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "120" },
        },
      },
    },
  },
  {
    "danymat/neogen",
    opts = {
      languages = {
        python = {
          template = {
            annotation_convention = "reST",
          },
        },
      },
    },
  },
}
