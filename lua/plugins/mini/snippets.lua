local make_stop = function()
  local au_opts = { pattern = '*:n', once = true }
  au_opts.callback = function()
    while MiniSnippets.session.get() do
      MiniSnippets.session.stop()
    end
  end
  vim.api.nvim_create_autocmd('ModeChanged', au_opts)
end
  local opts = { pattern = 'MiniSnippetsSessionStart', callback = make_stop }
  vim.api.nvim_create_autocmd('User', opts)
local gen_loader = require('mini.snippets').gen_loader
return {
  snippets = {
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
  expand = {
    stop = "<esc>"
  }
}
