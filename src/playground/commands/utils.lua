--- Wrap a function to make it a valid command in the playground
---
--- @param func function
--- @param description string
---
--- @return {program: function, description: string}
local function cmd(func, description)
    return {
        program = function(params)
            if params then
                return func(params)
            end

            return func()
        end,
        description = description
    }
end

--- Extracts options from the provided arguments denoted
--- with the '-' character at the start of the argument
---
--- @param args metatable
--- @return metatable
local function get_options(args)
    local options = {}

    for _, v in pairs(args) do
        local c_val = v;

        local c_key = string.gsub(v, '-', '')
        local exists_eq = string.find(v, '=')

        if exists_eq then
            c_val = string.sub(v, exists_eq, string.len(v))
        end

        options[c_key] = c_val
    end

    return options
end

return {
    cmd = cmd,
    get_options = get_options
}
