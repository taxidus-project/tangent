require "os"

--- Clear the console screen
---
--- @return nil
local function clear_screen()
    if not os.execute("clear") then
        os.execute("cls")
    end
end

--- Ask for input from the user in the console
---
--- @param msg string
--- @param read readmode
---
--- @return string
local function input(msg, read)
    io.write(msg)
    return io.read(read)
end

--- Split a string based on the given seperator
---
--- @param src string
--- @param seperator string
---
--- @return {integer: string}
local function str_split(src, seperator)
    assert(type(src) == "string", "TypeError: src in str_split must be the type of string!")
    assert(type(seperator) == "string", "TypeError: seperator in str_split must be the type of string!")

    if seperator == nil then
        seperator = "%s"
    end

    local tokens = {}

    for str in string.gmatch(src, "([^" .. seperator .. "]+)") do
        table.insert(tokens, str)
    end

    return tokens
end

--- Merge two tables into one unified array
---
--- @param t1 metatable
--- @param t2 metatable
---
--- @return metatable
local function merge(t1, t2)
    local result = {}

    for k, v in pairs(t1) do
        result[k] = v
    end

    for k, v in pairs(t2) do
        result[k] = v
    end

    return result
end

--- Get the amount of entries inside the given metatable
---
--- @param t any
local function length(t)
    local count = 0

    for _ in pairs(t) do count = count + 1 end

    return count
end

return {
    clear = clear_screen,
    input = input,
    str_split = str_split,
    merge = merge,
    length = length,
}
