return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local wk = require("which-key")

          wk.add({
            { "<leader>h", group = "git signs" },
            {
              "<leader>hs",
              gitsigns.stage_hunk,
              desc = "Stage hunk",
              buffer = bufnr,
            },
            {
              "<leader>hr",
              gitsigns.reset_hunk,
              desc = "Reset hunk",
              buffer = bufnr,
            },
            {
              "<leader>hS",
              gitsigns.stage_buffer,
              desc = "Stage buffer",
              buffer = bufnr,
            },
            {
              "<leader>hu",
              gitsigns.undo_stage_hunk,
              desc = "Undo stage hunk",
              buffer = bufnr,
            },
            {
              "<leader>hR",
              gitsigns.reset_buffer,
              desc = "Reset buffer",
              buffer = bufnr,
            },
            {
              "<leader>hp",
              gitsigns.preview_hunk,
              desc = "Preview hunk",
              buffer = bufnr,
            },
            {
              "<leader>hb",
              function()
                gitsigns.blame_line({ full = true })
              end,
              desc = "Blame line",
              buffer = bufnr,
            },
            {
              "<leader>hd",
              gitsigns.diffthis,
              desc = "Preview diff this",
              buffer = bufnr,
            },
          })
        end,
      })
    end,
  },
}
