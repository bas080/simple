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

minetest.register_node("meseores:solar_panel", {
	drawtype = "signlike",
	tile_images = {"jeija_solar_panel.png"},
	inventory_image = "jeija_solar_panel.png",
	wield_image = "jeija_solar_panel.png",
	paramtype = "light",
    paramtype2 = "wallmounted",
	sunlight_propagates = true,
    walkable = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
    selection_box = {
        type = "wallmounted",
    --wall_top = <default>
    --wall_bottom = <default>
    --wall_side = <default>
    },
    material = minetest.digprop_constanttime(0.5),
    description="Solar Panel",
})

minetest.register_alias("meseores:solar_panel", "meseores:mesecon_on")
