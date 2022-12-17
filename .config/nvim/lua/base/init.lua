require("base.plugins")
require("base.keymaps")

local base = {}

function base.requireIfExists(module)
	pcall(require, module)
end

return base

