return {
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      doc_lines = 0,
      hint_prefix = {
        above = "󰮵 ",
        current = "󰮹 ",
        below = "󰮻 "
      },
      handler_opts = {
        border = "none"
      }
    },
  }
}
