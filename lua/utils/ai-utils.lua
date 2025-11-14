local function createAdapters(tbl, url)
	local models = tbl.models
	local adapters = {
		http = {
			opts = {
				show_defaults = false,
			},
		},
	}
	for _, model in ipairs(models) do
		adapters.http["devx-" .. model.model] = function()
			local schema = { model = { default = model.model } }
			if model.completinOtions then
				for key, param in ipairs(model.completinOtions) do
					schema[key] = { default = param }
				end
			end

			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = url,
					api_key = function()
						return model.apiKey
					end,
				},
				headers = {
					["Content-Type"] = "application/json",
					["X-Copilot-User-Agent"] = "devxcopilot/2.0",
					["X-Copilot-User-Token"] = model.apiKey,
				},
				schema = schema,
			})
		end
	end
	return adapters
end

return {
	createAdapters = createAdapters,
}
