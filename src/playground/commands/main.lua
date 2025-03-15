local utils = require("src.lib.utils")

local sys_cmd = require("src.playground.commands.sys")
local engine_cmd = require("src.playground.commands.engine")

local commands = {}
local merged_commands = utils.merge(commands, engine_cmd, sys_cmd)

if not merged_commands then
    error("ProgramError: Failed merging external commands into command map")
end

return merged_commands
