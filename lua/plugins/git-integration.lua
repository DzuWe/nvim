return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function()
          local gitsigns = require("gitsigns")
          local wk = require("which-key")
          local wkb = require("which-key.extras").expand.buf

          wk.add({
            { "<leader>h", group = "git signs" },
            {
              "<leader>hs",
              gitsigns.stage_hunk,
              desc = "Stage hunk",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hr",
              gitsigns.reset_hunk,
              desc = "Reset hunk",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hS",
              gitsigns.stage_buffer,
              desc = "Stage buffer",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hu",
              gitsigns.undo_stage_hunk,
              desc = "Undo stage hunk",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hR",
              gitsigns.reset_buffer,
              desc = "Reset buffer",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hp",
              gitsigns.preview_hunk,
              desc = "Preview hunk",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hb",
              function()
                gitsigns.blame_line({ full = true })
              end,
              desc = "Blame line",
              expand = function()
                return wkb()
              end,
            },
            {
              "<leader>hd",
              gitsigns.diffthis,
              desc = "Preview diff this",
              expand = function()
                return wkb()
              end,
            },
          })
        end,
      })
    end,
  },
}
