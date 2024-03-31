package.loaded["lua.cmd_palette.init"] = nil
local init = require("lua.cmd_palette.init")

local function run(opts)
    init.show_palette(opts)
end

run(require("telescope.themes").palette{})

return require("telescope").register_extension({
    setup = setup,
    exports = {
        command_palette = run,
    }
})

