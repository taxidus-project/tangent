local config = require("src.config")

local utils = require("src.lib.utils")
local cmd_utils = require("src.playground.commands.utils")

local engine_cmd = require("src.playground.commands.engine")

local commands = {
    clear = cmd_utils.cmd(utils.clear, "Clears the screen"),
}

commands["info"] = cmd_utils.cmd(function(_args)
    print(string.format("%s\n", config.APP_NAME))
    print(string.format("Version\t: %s", config.APP_VERSION))
    print(string.format("Vendor\t: %s", config.APP_VENDOR))
end, "Displays info about the playground")

commands = utils.merge(commands, engine_cmd)

return commands
