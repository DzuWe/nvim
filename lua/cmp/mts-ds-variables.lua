--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

local registered = false
local cmp_data = {}

local function table_include(table, value)
  for _, element in pairs(table) do
    if element == value then
      return true
    end
  end
  return false
end

local function parseSingleLineCSSProperties(file)
  --- @module 'vim'
  --- @class lsp.CompletionItem[]
  local parsedTable = {}
  local cr = '\n'

  local CSS_PROPERTY_REGEX = '(-%-([a-zA-Z]+)%-(%S+)): (.-)%;'

  for _, line in ipairs(file) do
    for property, outerKey, innerKey, value in line:gmatch(CSS_PROPERTY_REGEX) do
      if outerKey and value then
        local k = outerKey .. ' ' .. innerKey:gsub("-", " ")

        --- @class lsp.CompletionItem
        table.insert(parsedTable, {
          label = k,
          documentation = string.format(
            'Figma Variable: ' .. '%s' .. cr ..
            'CSS Property: ' .. '%s' .. cr ..
            'Value: ' .. '%s'
            , k, property, value),
          insertText = property
        })
      end
    end

    return parsedTable
  end
end


local function loadProperties()
  if registered then return end

  local workspace_root = vim.fn.getcwd()
  local node_modules_path = "/node_modules/offering-ui"
  local config_wrapper = "/dist/granat-config-wrapper.js"
  local data = nil

  local possible_paths = {
    workspace_root .. config_wrapper,
    workspace_root .. node_modules_path .. config_wrapper,
  }

  for _, path in ipairs(possible_paths) do
    local ok, content = pcall(vim.fn.readfile, path)
    if not ok then
      goto continue
    end
    data = content
    ::continue::
  end

  if not data then
    return
  end
  cmp_data = parseSingleLineCSSProperties(data)
end

function source.new()
  loadProperties()
  local self = setmetatable({}, { __index = source })
  return self
end

function source:enabled()
  return table_include({ 'ts', 'vue', 'html', 'css', 'scss' }, vim.bo.filetype)
end

function source:get_trigger_characters()
  return { "-" }
end

function source:get_completions(ctx, cb)
  cb({
    items = cmp_data,
    is_incomplete_backward = false,
    is_incomplete_forward = false
  })
  return function() end
end

return source
