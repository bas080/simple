minetest.register_node("blocks:stone_bricks", {
	description = "Stone bricks",
	tiles = {"blocks_stone_bricks.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'blocks:stone_bricks',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "blocks:stone_bricks 4",
	recipe = {
		{'','default:stone','default:stone'},
		{'default:stone','default:stone',''},
	}
})
