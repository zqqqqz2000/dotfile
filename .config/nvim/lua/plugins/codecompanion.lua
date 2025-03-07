return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openai_compatible",
      },
      inline = {
        adapter = "openai_compatible",
      },
    },
    adapters = {
      openai_compatible = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            api_key = 'cmd:op read "op://Private/openrouter key - nvim/credential" --no-newline',
            url = "https://openrouter.ai/api",
            chat_url = "/v1/chat/completions",
          },
          schema = {
            model = {
              default = "qwen/qwq-32b:free",
            },
          },
        })
      end,
    },
  },
}
