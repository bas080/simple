minetest.register_node("map:map", {
	description = "Map",
	drawtype = "signlike",
	walkable = false,
	tiles = {"map.png"},
	wield_image =  "map.png",
	inventory_image =  "map.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {
		type = "wallmounted",
	},
	groups = {oddly_breakable_by_hand = 3}, 
})

minetest.register_craft({
	output = "map:map",
	recipe = {
		{"default:paper", "default:paper"},
		{"default:paper", "default:paper"}
	},
})

local path = minetest.get_modpath("map").."/"
local map = io.open(path.."/textures/map.png", "r")
if not map then
	print("[map] No map image found. Creating image... (This will take some time)")
	local result = os.execute("python "..path.."minetestmapper.py -i "..minetest.get_worldpath().." -o "..path.."/textures/map.png")
	print("[map] debug: "..result)
	if result ~= 1 then
		print("[map] Failed!")
		print("[map] Tried to run command \"python "..path.."minetestmapper.py -i "..minetest.get_worldpath().." -o "..path.."/textures/map.png\"")
	end
end