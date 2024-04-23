return {
  'nativerv/cyrillic.nvim',
  event = { 'VeryLazy' },
  config = function ()
    require('cyrillic').setup()
  end
}
