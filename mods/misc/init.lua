minetest.register_node("misc:horizontal_tree", {
	description = "Tree side",
	tile_images = { 
		"misc_horizontaltree.png", 
		"misc_horizontaltree.png",
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"misc_horizontaltree.png", 
		"misc_horizontaltree.png" 
	},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})


-- craft horizontal trees
minetest.register_craft({
	output = '"misc:horizontal_tree" 2',
	recipe = {
		{'"default:tree"', '"default:tree"'},
	}
})

-- craft horizontal trees back to normal trees
minetest.register_craft({
	output = '"default:tree" 2',
	recipe = {
		{'"misc:horizontal_tree"'},
		{'"misc:horizontal_tree"'},
	}
})


