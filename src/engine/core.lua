local config = require("src.config")

local Engine = {}

function Engine.version()
    return config.ENGINE_VERSION
end

function Engine.platform()
    return config.ENGINE_PLATFORM
end

function Engine.vendor()
    return config.ENGINE_VENDOR
end

return Engine
