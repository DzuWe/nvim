return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim'
  },
  branch = 'v3.x',
  config = function()
    require('neo-tree').setup {}
    vim.keymap.set('n', '<leader>ne', '<CMD>Neotree toggle<CR>', {desc = 'Toggle neo-tree'})
    vim.keymap.set('n', '<leader>ng', '<CMD>Neotree git_status right toggle<CR>', {desc = 'Toggle git status'})
    vim.keymap.set('n', '<leader>nb', '<CMD>Neotree buffers right toggle<CR>', {desc = 'Toggle buffers'})
  end
 }
