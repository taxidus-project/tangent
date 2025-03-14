package.path = package.path .. ";./src/?.lua"

local playground = require("src.playground.main")

local function main()
	playground.playground()
end

main()
