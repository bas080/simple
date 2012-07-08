minetest.register_node("moreblocks:horizontaltree", {
	description = "Tree",
	tile_images = {"default_tree.png", "default_tree.png", "moreblocks_horizontaltree.png",
		"moreblocks_horizontaltree.png", "default_tree_top.png", "default_tree_top.png"},
	is_ground_content = true,
	paramtype2 = "facedir",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_craft({
	output = '"moreblocks:horizontaltree" 2',
	recipe = {
		{'"default:tree"', '"default:tree"'},
	}
})



minetest.register_craft({
	output = '"default:tree" 2',
	recipe = {
		{'"moreblocks:horizontaltree"'},
		{'"moreblocks:horizontaltree"'},
	}
})

