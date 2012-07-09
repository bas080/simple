minetest.register_node("cube:cube_storage", {
	tile_images = {"cube_storage.png"},
	inventory_image = minetest.inventorycube("cube_storage.png"),
	is_ground_content = true,
	cookresult_item = 'CraftItem "scorched_stuff" 1',
	material = minetest.digprop_constanttime(0.0),
})

minetest.register_craft({
	output = 'NodeItem "cube:cube_storage" 1',
	recipe = {
		{'CraftItem "steel_ingot"', 'NodeItem "stone"', 'CraftItem "steel_ingot"'},
		{'NodeItem "stone"', '', 'NodeItem "stone"'},
		{'CraftItem "steel_ingot"', 'NodeItem "stone"', 'CraftItem "steel_ingot"'},
	}
})

minetest.register_node("cube:cube_companion", {
	tile_images = {"cube_companion.png"},
	inventory_image = minetest.inventorycube("cube_companion.png"),
	is_ground_content = true,
	cookresult_item = 'CraftItem "scorched_stuff" 1',
	material = minetest.digprop_constanttime(0.0),
})

minetest.register_craft({
	output = 'NodeItem "cube:cube_companion" 1',
	recipe = {
		{'CraftItem "steel_ingot"', 'NodeItem "stone"', 'CraftItem "steel_ingot"'},
		{'NodeItem "stone"', 'CraftItem "apple"', 'NodeItem "stone"'},
		-- apple should probably a rose, soulstone or something else we do not have yet
		{'CraftItem "steel_ingot"', 'NodeItem "stone"', 'CraftItem "steel_ingot"'},
	}
})
