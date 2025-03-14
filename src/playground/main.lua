require "string"
require "io"

local utils = require("src.lib.utils")
local commands = require("playground.commands.main")

local function list_screen()
    local max_cmd_length = 0

    for key, _ in pairs(commands) do
        max_cmd_length = math.max(max_cmd_length, #key)
    end

    print("\nAvailable Commands:")
    print(string.rep("-", max_cmd_length + 40))

    local sorted_commands = {}
    for key in pairs(commands) do
        table.insert(sorted_commands, key)
    end
    table.sort(sorted_commands)

    for _, key in ipairs(sorted_commands) do
        local padding = string.rep(" ", max_cmd_length - #key + 4)
        print(string.format("%s%s%s", key, padding, commands[key].description))
    end

    print(string.rep("-", max_cmd_length + 40))
end

local function playground()
    print("Welcome to the Tangent playground!")
    print("Type help or list for a quickstart")

    while true do
        io.write("\n>> ")
        local args = utils.str_split(io.read("l"), ' ')

        --- @type string
        local cmd = args[1]

        if cmd == "exit" then
            print("Bye!")
            break
        elseif commands[cmd] then
            local status, err = pcall(function()
                commands[cmd].program(args)
            end)

            if not status then
                print("Error executing command: " .. err)
            end
        elseif cmd == "list" then
            list_screen()
        else
            print(string.format("Command %s does not exist!", cmd))
        end
    end
end

return {
    playground = playground
}
