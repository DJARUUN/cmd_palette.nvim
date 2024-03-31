local M = {}

local function get_keymaps_and_commands()
    local keymaps_and_commands = {}

    local full_keymaps = vim.api.nvim_get_keymap("")
    for _, keymap in pairs(full_keymaps) do
        table.insert(keymaps_and_commands, {
            desc = keymap.desc,
            lhs = keymap.lhs,
            mode = keymap.mode,
            action = function()
                vim.api.nvim_input(keymap.lhs)
            end,
        })
    end

    local full_commands = vim.api.nvim_get_commands({})
    for _, command in pairs(full_commands) do
        table.insert(keymaps_and_commands, {
            desc = command.name,
            lhs = "",
            mode = "c",
            action = function()
                vim.api.nvim_command(command.name)
            end
        })
    end

    return keymaps_and_commands
end

M.keymaps_and_commands = get_keymaps_and_commands()

local key_pairs_lookup = {
    [" "] = "<Space>",
}

function M.parse_keys(keys)
    local parsed_keys = ""

    for i = 1, #keys do
        local key = string.sub(keys, i, i)
        parsed_keys = key_pairs_lookup[key] and parsed_keys .. key_pairs_lookup[key] or parsed_keys .. key
    end
    return parsed_keys
end

return M
