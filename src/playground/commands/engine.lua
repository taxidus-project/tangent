local engine = require("src.engine.main")

local utils = require("src.lib.utils")
local cmd_utils = require("src.playground.commands.utils")

--- The engine stores commands
---
--- @param args table
---
local function stores_cmd(args)
    assert(utils.length(args) > 1, "Command needs more than 1 argument")

    local options = cmd_utils.get_options(args)

    --- @type string
    local mode = args[2]

    if options["help"] or options['h'] then
        cmd_utils.help(
            "This command provides the following for manipulating engine stores",
            "stores [mode] [--options]",
            {
                {
                    title = "create",
                    desc = "Create a store inside the engine"
                },
                {
                    title = "get",
                    desc = "Fetch an existing store from the engine"
                },
                {
                    title = "remove",
                    desc = "Remove an existing store from the engine",
                },
                {
                    title = "list",
                    desc = "List all created stores"
                },
                {
                    title = "clear",
                    desc = "Clear all created stores"
                }
            }
        )

        return
    end

    if mode == "create" then
        local k = utils.input("Key: ", "l")
        local v = utils.input("Value: ", "l")

        if not engine.stores.create(k, v) then
            print("StoresError: Key already exists!")
        else
            print(string.format("Successfully stored %s in stores!", k))
        end
    elseif mode == "get" then
        local k = utils.input("Key: ", "l")

        local v = engine.stores.get(k)

        if not v then
            print("StoresError: Failed to fetch, key doesn't exist!")
        else
            print(string.format("Fetched: %s from %s", v, k))
        end
    elseif mode == "remove" then
        local k = utils.input("Key: ", "l")

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
        print(string.format("Stores mode %s does not exist! please refer to -h or --help for more info", mode))
    end
end

--- The engine resource commands
---
--- @param args table
---
local function resource_cmd(args)
    assert(utils.length(args) > 1, "Command needs more than 1 argument")

    local options = cmd_utils.get_options(args)

    --- @type string
    local mode = args[2]

    if options["help"] or options['h'] then
        cmd_utils.help(
            "This command provides the following to manipulate engine resources",
            "resource [mode] [--options]",
            {
                {
                    title = "load",
                    desc = "Loads a resource onto the engine"
                },
                {
                    title = "unload",
                    desc = "Unloads an existing resource from the engine"
                },
                {
                    title = "get",
                    desc = "Fetches an existing resource from the engine"
                },
            }
        )

        return
    end

    if mode == "load" then
        local k = utils.input("Key: ", "l")

        --- TODO: Make this a proper to import resources other than text
        local mock = utils.input("Resource: ", "l")

        if not engine.resource.load(k, { data = { mock }, type = "text", ref = "playground:local" }) then
            print("ResourceError: Key already exists!")
            return
        end

        print("Successfully loaded resource!")
    elseif mode == "unload" then
        local k = utils.input("Key: ", "l")

        if not engine.resource.unload(k) then
            print("ResourceError: Key doesn't exist!")
            return
        end

        print("Successfully unloaded resource from engine!")
    elseif mode == "get" then
        local k = utils.input("Key: ", "l")
        local resource = engine.resource.get(k)

        if not resource then
            print(string.format("Resource with key %s does not exist!", k))
            return
        end

        print(string.format("Type: %s", resource.type))
        if resource.ref then print(string.format("Reference: %s", resource.ref)) end

        print("Dataset:")
        for key, value in pairs(resource.data) do
            print(string.format("%s => %s", key, value))
        end
    else
        print(string.format("Resource mode %s does not exist! please refer to -h or --help for more info", mode))
    end
end

--- The engine core commands
---
--- @param args table
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
    elseif options["help"] then
        cmd_utils.help(
            "This command provides the following to manipulate the engine core",
            "core [--options]",
            {
                {
                    title = "--version",
                    desc = "Get the current engine version"
                },
                {
                    title = "--platform",
                    desc = "Get the platform running the engine"
                },
                {
                    title = "--vendor",
                    desc = "Get the vendor providing the engine"
                }
            }
        )
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
