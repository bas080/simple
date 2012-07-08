minetest.register_alias("flowers:cotton", "cotton:cotton")

local COLORS = {
    "green",
    "black",
    "red",
    "orange",
    "yellow",
    "blue",
    "violet",
}

for i, color in ipairs(COLORS) do
	local fname = 'cotton:cotton_' .. color
	
	minetest.register_node(fname, {
	tile_images = {"cotton_" .. color .. ".png"},
	inventory_image = minetest.inventorycube("cotton_" .. color .. ".png"),
	description = color .. " cotton cube",
	drawtype = 'nodebox',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	furnace_burntime = 1,
	groups = {snappy=3},
	sounds = default.node_sound_cotton_defaults(),
})
	
	minetest.register_craft({
	output = fname,
	recipe = {
		{'cotton:cotton'},
		{'unifieddyes:' .. color},
	}
})

end

minetest.register_alias("flowers:cotton", "cotton:cotton")

minetest.register_node("cotton:cotton", {
	tile_images = {"cotton_cotton.png"},
	inventory_image = minetest.inventorycube("cotton_cotton.png"),
	description = "Cotton Cube",
	drawtype = 'nodebox',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	furnace_burntime = 1,
	groups = {snappy=3},
	sounds = default.node_sound_cotton_defaults(),
})

minetest.register_craft({
	output = 'cotton:cotton 4',
	recipe = {
		{'farming:cotton','farming:cotton'},
		{'farming:cotton', 'farming:cotton'},
	}
})

minetest.register_craft({
	output = 'cotton:cotton 4',
	recipe = {
		{'flowers:cotton','flowers:cotton'},
		{'flowers:cotton', 'flowers:cotton'},
	}
})

