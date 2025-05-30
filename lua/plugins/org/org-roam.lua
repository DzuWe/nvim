return {
  "chipsenkbeil/org-roam.nvim",
  tag = "0.1.1",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.3.7",
    },
  },
  config = function()
    require("org-roam").setup({
      templates = {
        t = {
          description = "thesis",
          template = "* %?\n ** Простыми словами \n ** Расширенное описание\n ** Примеры",
          target = "Dictionary%[sep]Thesises%[sep]%[title].org",
        },
        d = {
          description = "default",
          template = "%?",
          target = "Notes%[sep]%<%Y%m%d%H%M%S>-%[title].org",
        },
      },
      directory = "~/orgfiles",
      extensions = {
        dailies = {
          directory = "Notes/Daily"
        }
      }
    })
  end
}
