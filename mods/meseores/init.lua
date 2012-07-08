minetest.register_craft({
		output = '"mesecons:mesecon_off" 16',
		recipe = {
			{'moreores:copper_ingot',''},
			{'',''},
			{'',''},
		}
	})
	
	
	minetest.register_craft({
	output = '"mesecons_pistons:piston_normal" 2',
	recipe = {
		{'','default:stick',''},
		{'default:stone','mesecons:mesecon_off', 'default:wood'},
		{'','default:stick',''},
	}
})

minetest.register_craft({
	output = '"mesecons_pistons:piston_sticky" 1',
	recipe = {
		{'','default:stick',''},
		{'default:stone','mesecons:mesecon_off', 'default:wood'},
		{'','default:stick',''},
	}
})

minetest.register_craft({
	output = '"mesecons_materials:glue" 2',
	recipe = {
		{'"default:leaves"', '"default:leaves"'},
		{'"default:leaves"', '"default:leaves"'},
	}
})
