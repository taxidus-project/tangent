local config = require("src.config")
local utils = require("src.lib.utils")

local Store = {
    data = {}
}

function Store.create(key, value)
    if utils.length(Store.data) >= config.ENGINE_STORE_MAX_KEYS then
        return false
    end

    if not Store.data[key] then
        Store.data[key] = value
        return true
    end

    return false
end

function Store.get(key)
    if not Store.data[key] then
        return nil
    end

    return Store.data[key]
end

function Store.remove(key)
    if not Store.data[key] then
        return false
    end

    Store.data[key] = nil

    return true
end

function Store.update(key, value)
    if not Store.data[key] then
        return false
    end

    Store.data[key] = value

    return true
end

function Store.exists(key)
    if not Store.data[key] then
        return false
    end

    return true
end

function Store.clear()
    if Store.data.__len <= 0 then
        return false
    end

    Store.data = {}

    return true
end

return Store
