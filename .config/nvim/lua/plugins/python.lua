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
      formatters = {
        black = {
          prepend_args = { "--line-length", "120" },
        },
      },
    },
  },
  {
    "SUSTech-data/neopyter",
    dependencies = {
      "AbaoFromCUG/websocket.nvim",
    },
    ---@type neopyter.Option
    opts = {
      mode = "direct",
      remote_address = "127.0.0.1:9001",
      file_pattern = { "*.ju.*" },
      on_attach = function(buf)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buf })
        end
        map("n", "<leader><CR>", "<cmd>Neopyter run current<cr>", "run selected")
        map("n", "<leader>n", "/# %%<cr>", "next cell")
        map("n", "<leader>r", "<cmd>Neopyter kernel restart<cr>", "restart kernel")
        map("n", "<leader>rr", "<cmd>Neopyter execute notebook:restart-run-all<cr>", "restart kernel and run all")
      end,
      highlight = {
        enable = true,
      },
    },
  },
}
