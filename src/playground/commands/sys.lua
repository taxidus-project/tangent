local config = require("src.config")

local utils = require("src.lib.utils")
local cmd_utils = require("src.playground.commands.utils")

local function playground_info(_args)
    print(string.format("%s\n", config.APP_NAME))
    print(string.format("Version\t: %s", config.APP_VERSION))
    print(string.format("Vendor\t: %s", config.APP_VENDOR))
end

return {
    clear = cmd_utils.cmd(utils.clear, "Clears the screen"),
    info = cmd_utils.cmd(playground_info, "Displays info about the playground"),
}
