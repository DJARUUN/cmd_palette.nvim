local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("cmd_palette.nvim requires telescope.nvim - https://github.com/nvim-telescope/telescope.nvim")
end

package.loaded["lua.cmd_palette.nvim.init"] = nil
local init = require("lua.cmd_palette.nvim.init")

local run = function(opts)
    init.show_palette(opts)
end

return telescope.register_extension({
    setup = function(ext_config, config) end,
    exports = {
        colors = run,
    }
})

