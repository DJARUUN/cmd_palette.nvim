local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("cmd_palette.nvim requires telescope.nvim - https://github.com/nvim-telescope/telescope.nvim")
end

package.loaded["cmd_palette.init"] = nil
local cmd_palette = require("cmd_palette.init")

local run = function(opts)
    cmd_palette.show_palette(opts)
end

return telescope.register_extension({
    setup = function(ext_config, config) end,
    exports = {
        cmd_palette = run,
    }
})

