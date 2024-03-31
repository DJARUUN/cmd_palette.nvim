local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values

-- package.loaded["lua.cmd_palette.helpers"] = nil
-- package.loaded["lua.cmd_palette.configs"] = nil

function M.show_palette(opts)
    local configs = require("cmd_palette.configs")
    local helpers = require("cmd_palette.helpers")

    opts = opts or {}

    pickers.new(opts, {
        prompt_title = "CMD Palette",

        finder = finders.new_table({
            results = helpers.keymaps_and_commands,

            entry_maker = function(entry)
                local parsed_keys = helpers.parse_keys(entry.lhs)

                local lhs_width = #parsed_keys
                local mode_with = #entry.mode
                local padding = 10
                local desc_width = configs.width - lhs_width + mode_with - padding

                local displayer = entry_display.create({
                    separator = " ",
                    items = {
                        {width = desc_width},
                        {remaining = lhs_width},
                        {width = mode_with},
                    },
                })

                local function make_display()
                    return displayer({
                        {entry.desc or ""},
                        {parsed_keys, "TelescopePromptCounter"},
                        {entry.mode, "TelescopeBorder"},
                    })
                end

                return {
                    value = entry,
                    display = make_display,
                    ordinal = entry.desc,
                }
            end,
        }),

        sorter = conf.generic_sorter(opts),

        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)

                local selection = action_state.get_selected_entry()
                selection.value.action()
            end)

            map("i", "<Tab>", function() actions.move_selection_next(prompt_bufnr) end)
            map("i", "<S-Tab>", function() actions.move_selection_previous(prompt_bufnr) end)

            return true
        end,
    }):find()
end

return M
