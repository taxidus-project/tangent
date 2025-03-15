local Resource = {
    stored = {}
}

--- Describes on how to create a resource
---
--- @class ResourceData
--- @field data table
--- @field type string|"image"|"text"|"object"
--- @field ref string|nil

--- Loads a resource to be stored inside the engine
---
--- @param key string
--- @param data ResourceData
---
function Resource.load(key, data)
    assert(type(key) == "string", "TypeError: Key must be a string!")

    if not Resource.stored[key] then
        Resource.stored[key] = data
        return true
    end

    return false
end

--- Removes a loaded resource from the engine
---
--- @param key string
---
function Resource.unload(key)
    assert(type(key) == "string", "TypeError: Key must be a string!")

    if not Resource.stored[key] then
        return false
    end

    Resource.stored[key] = nil
    return true
end

--- Check too see if a resource has been loaded in the engine
---
--- @param key string
---
function Resource.exists(key)
    assert(type(key) == "string", "TypeError: Key must be a string!")

    if not Resource.stored[key] then
        return false
    end

    return true
end

--- Get a resource from the engine
---
--- @param key string
---
--- @return nil|ResourceData
function Resource.get(key)
    assert(type(key) == "string", "TypeError: Key must be a string!")

    if not Resource.exists(key) then return nil end

    return Resource.stored[key]
end

return Resource
