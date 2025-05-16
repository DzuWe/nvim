local mini_modules = {
  "surround", --"starter",
  "comment",
  "snippets",
  "indentscope",
  "ai",
}

local modules_path = "plugins.mini."
return {
  "echasnovski/mini.nvim",
  config = function()
    for _, m in ipairs(mini_modules) do
      local cfg_status, cfg = pcall(require, modules_path .. m)
      local module_status, module = pcall(require, "mini." .. m)

      if not cfg_status then
        cfg = {}
      end

      if not module_status then
        goto continue
      end

      module.setup(cfg)
      ::continue::
    end
  end,
}
