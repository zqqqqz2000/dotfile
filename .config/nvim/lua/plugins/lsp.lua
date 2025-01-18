return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = {
      "<c-k>",
      false,
      mode = "i",
    }
    opts.servers.clangd.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
  end,
}
