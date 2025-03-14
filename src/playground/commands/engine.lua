local engine = require("src.engine.main")

local utils = require("src.lib.utils")
local cmd_utils = require("src.playground.commands.utils")

--- The engine stores commands
---
--- @param args metatable
---
local function stores_cmd(args)
    assert(utils.length(args) > 1, "Command needs more than 1 argument")

    --- @type string
    local mode = args[2]

    if mode == "create" then
        local k = utils.input("key: ", "l")
        local v = utils.input("value: ", "l")

        if not engine.stores.create(k, v) then
            print("StoresError: Key already exists!")
        else
            print(string.format("Successfully stored %s in stores!", k))
        end
    elseif mode == "get" then
        local k = utils.input("key: ", "l")

        local v = engine.stores.get(k)

        if not v then
            print("StoresError: Failed to fetch, key doesn't exist!")
        else
            print(string.format("Fetched: %s from %s", v, k))
        end
    elseif mode == "remove" then
        local k = utils.input("key: ", "l")

        if not engine.stores.remove(k) then
            print("StoresError: Failed to remove, key doesn't exist!")
        else
            print(string.format("Successfully removed %s from stores!", k))
        end
    elseif mode == "list" then
        print("Sorry for the incovenience, but this mode is currently not available")
    elseif mode == "clear" then
        if not engine.stores.clear() then
            print("StoresError: Stores are already empty!")
        else
            print("Successfully cleared stores!")
        end
    else
        -- TODO! This should be an error() in the future
        print(string.format("Stores mode %s does not exist! please refer to -h or --help for more info"), mode)
    end
end

--- The engine resource commands
---
--- @param args metatable
---
local function resource_cmd(args)
    assert(utils.length(args) > 1, "Command needs more than 1 argument")

    print("Sorry for the incovenience, but this command is still a WIP")
end

--- The engine core commands
---
--- @param args metatable
---
local function core_cmd(args)
    assert(utils.length(args) > 1, "Command needs more than 1 argument")

    local options = cmd_utils.get_options(args)

    if options["version"] then
        print(string.format("Engine version: %s", engine.core.version()))
    elseif options["platform"] then
        print(string.format("Engine platform: %s", engine.core.platform()))
    elseif options["vendor"] then
        print(string.format("Engine vendor: %s", engine.core.vendor()))
    else
        -- TODO! This should be an error() in the future
        print(string.format("Engine command does not exist!"))
    end
end

return {
    stores = cmd_utils.cmd(function(args)
        stores_cmd(args)
    end, "The engine store commands"),

    core = cmd_utils.cmd(function(args)
        core_cmd(args)
    end, "The engine core commands"),

    resource = cmd_utils.cmd(function(args)
        resource_cmd(args)
    end, "The engine resource commands"),
}
