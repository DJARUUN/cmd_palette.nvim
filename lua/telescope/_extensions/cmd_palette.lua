local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("cmd_palette.nvim requires telescope.nvim - https://github.com/nvim-telescope/telescope.nvim")
end

local run = function(opts)
    require("cmd_palette").show_palette(opts)
end

return telescope.register_extension({
    setup = function(ext_config, config) end,
    exports = {
        cmd_palette = run,
    }
})

