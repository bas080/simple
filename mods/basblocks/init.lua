-- Side wood blocks
minetest.register_node("basblocks:tree_horizontal", {
	description = "Tree",
	tile_images = {"default_tree.png", "default_tree.png", "default_tree.png",
		"default_tree.png", "default_tree_top.png", "default_tree_top.png"},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'basblocks:tree_horizontal 2',
	recipe = {
		{'default:tree', 'default:tree'},
	}
})

minetest.register_craft({
	output = 'default:tree 2',
	recipe = {
		{'basblocks:tree_horizontal'},
		{'basblocks:tree_horizontal'},
	}
})
