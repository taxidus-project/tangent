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
--- @param args table
--- @return table
local function get_options(args)
    --- TODO: Maybe seperate flags and values?
    local options = {}

    for _, v in pairs(args) do
        local c_val = v;

        local c_key = string.gsub(v, '-', '')
        local exists_eq = string.find(v, '=')

        if exists_eq then
            c_val = string.sub(v, exists_eq + 1, string.len(v))
        end

        options[c_key] = c_val
    end

    return options
end

--- Describes on how to create a help option for a command
---
--- @class CmdHelpOption
--- @field title string
--- @field desc string

--- Generate a help menu quickly for a command
---
--- @param desc string
--- @param struct string
--- @param options CmdHelpOption[]
local function help(desc, struct, options)
    print(string.format("%s\n", desc))
    print(string.format("%s\n", struct))

    for _, v in ipairs(options) do
        print(string.format("%-20s %s", v.title, v.desc))
    end
end

return {
    cmd = cmd,
    get_options = get_options,
    help = help,
}
