local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
    return
end

package.loaded["lua.cmd_palette.init"] = nil
local init = require("lua.cmd_palette.init")

local function run(opts)
    init.show_palette(opts)
end

-- run(require("telescope.themes").palette{})

return telescope.register_extension({
    setup = function(ext_config, config) end,
    exports = {
        ["cmd_palette"] = run,
        fortnite = run,
    }
})

