local M = {}

local themes = require("telescope.themes")

M.width = 85
M.height = 18

function themes.palette(opts)
    opts = opts or {}
    local theme_opts = {
        theme = "dropdown",
        results_title = "",
        layout_strategy = "vertical",
        layout_config = {
            anchor = "N",
            prompt_position = "top",
            width = M.width,
            height = M.height,
        },
    }
    return vim.tbl_deep_extend("force", theme_opts, opts)
end


return M
