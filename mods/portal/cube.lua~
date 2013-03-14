--[[
 weighted companion cube for minetest
	by Melkor
	
	Weighted Companion Cube for Celeron55' MineTest
  texture and nodebox Made By Melkor 
  Licence:
  Textures WTFPL
  Code WTFPL
--]]

minetest.register_alias('Weighted Companion Cube', 'wcc:wcc')

minetest.register_craft( {
	output = 'portal:wcc',
	recipe = {
		{ 'default:steelblock', 'default:steelblock', 'default:steelblock'},
		{ 'default:steelblock', 'default:apple', 'default:steelblock'},
		{ 'default:steelblock', 'default:steelblock', 'default:steelblock'},
	},
})

minetest.register_node("portal:wcc", {
	description = 'Weighted Companion Cube',
	is_ground_content = true,
	groups = {dig_immediate=3, falling_node=1},
	tiles = {
		"wcc.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = false,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
-- lets do it!
--		main body
			{-0.43750,-0.43750,-0.43750, 0.43750,0.43750,0.43750},
--		extras
			{-0.50000,0.18750,-0.50000,	-0.18750,0.50000,-0.18750},
			{-0.50000,-0.50000,-0.50000,	-0.18750,-0.18750,-0.18750},
			{-0.50000,0.18750,0.18750,		-0.18750,0.50000,0.50000},
			{-0.50000,-0.50000,0.18750,	-0.18750,-0.18750,0.50000},
			{0.18750,0.18750,0.18750,		0.50000,0.50000,0.50000},
			{0.18750,-0.50000,0.18750,		0.50000,-0.18750,0.50000},
			{0.18750,0.18750,-0.50000,		0.50000,0.50000,-0.18750},
			{0.18750,-0.50000,-0.50000,	0.50000,-0.18750,-0.18750},
		},
	},
})
