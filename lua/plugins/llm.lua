local ok, secrets = pcall(require, "secrets.mts-tokens")

if true or not ok or not secrets.devx then
  return {}
end

return {
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "devx",
          },
          inline = {
            adapter = "devx",
          },
          cmd = {
            adapter = "devx",
          },
        },
        adapters = {
          devx = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = secrets.devx.link,
                api_key =  'sk-' .. secrets.devx.token,
                chat_url = "/v1/chat/completions",
                inline_url = "/v1/completions"
              },
              schema = {
                model = {
                  default = "deepseek-coder",
                },
              },
            })
          end,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
