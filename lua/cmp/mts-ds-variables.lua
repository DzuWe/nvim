local function parseSingleLineCSSProperties(file)
  local parsedTable = {}
  local cr = '\n'

  local CSS_PROPERTY_REGEX = '(-%-([a-zA-Z]+)%-(%S+)): (.-)%;'

  for _, line in ipairs(file) do
    for property, outerKey, innerKey, value in line:gmatch(CSS_PROPERTY_REGEX) do
      if outerKey and value then
        local k = outerKey .. ' ' .. innerKey:gsub("-", " ")

        parsedTable[k] = {
          documentation = string.format(
            'Figma Variable: ' .. '%s' .. cr ..
            'CSS Property: ' .. '%s' .. cr ..
            'Value: ' .. '%s'
            , k, property, value),
          property = property,
          value = value
        }
      end
    end
  end

  return parsedTable
end

local ds_vars = {}
local registered = false

ds_vars.setup = function()
  if registered then
    return
  end
  registered = true

  local has_cmp, cmp = pcall(require, "cmp")
  if not has_cmp then
    return
  end

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

  local parsed_table = parseSingleLineCSSProperties(data)
  local source = {}

  ---Source constructor.
  source.new = function()
    local self = setmetatable({}, { __index = source })
    return self
  end

  ---Return the source is available or not.
  ---@return boolean
  function source:is_available()
    return true
  end

  ---Return the source name for some information.
  function source:get_debug_name()
    return 'mts-ds-variables'
  end

  ---Return trigger characters.
  function source:get_trigger_characters()
    return { '-' }
  end

  function source:complete(params, callback)
    local input = string.sub(params.context.cursor_before_line, params.offset - 2)
    local prefix = string.sub(params.context.cursor_before_line, 1, params.offset - 1)

    if vim.endswith(prefix, "--") then
      local items = {}
      for key, value in pairs(parsed_table) do
        table.insert(items, {
          label = key,
          documentation = value.documentation,
          textEdit = {
            newText = value.property,
            range = {
              start = {
                line = params.context.cursor.row - 1,
                character = params.context.cursor.col - 1 - #input,
              },
              ["end"] = {
                line = params.context.cursor.row - 1,
                character = params.context.cursor.col - 1,
              }
            }

          }
        })
      end
      callback({
        items = items,
        incomplete = true
      })
    else
      callback({ incomplete = true })
    end
  end

  function source:resolve(completion_item, callback)
    callback(completion_item)
  end

  function source:execute(completion_item, callback)
    callback(completion_item)
  end

  require('cmp').register_source(source.new())
  cmp.register_source("mts-ds-variables", source.new())
end

return ds_vars
