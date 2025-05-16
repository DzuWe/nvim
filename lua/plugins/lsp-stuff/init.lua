local function getModule(name)
	return require("plugins.lsp-stuff." .. name)
end

return {
  getModule('lsp-signature'),
  getModule('blink')
}
