-- The BLINKY_PLANT

minetest.register_node("mesecons_blinkyplant:blinky_plant_off", {
	drawtype = "plantlike",
	visual_scale = 1,
	tile_images = {"jeija_blinky_plant_off.png"},
	inventory_image = "jeija_blinky_plant_off.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2},
    	description="Blinky Plant",
})

minetest.register_node("mesecons_blinkyplant:blinky_plant_on", {
	drawtype = "plantlike",
	visual_scale = 1,
	tile_images = {"jeija_blinky_plant_on.png"},
	inventory_image = "jeija_blinky_plant_off.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2},
	drop='"mesecons_blinkyplant:blinky_plant_off" 1',
	light_source = LIGHT_MAX-7,
	description = "Blinky Plant",
	after_dig_node = function(pos)
		mesecon:receptor_off(pos)
	end
})

minetest.register_craft({
	output = '"mesecons_blinkyplant:blinky_plant_off" 1',
	recipe = {
	{'','"mesecons:mesecon_off"',''},
	{'','"mesecons:mesecon_off"',''},
	{'"default:leaves"','"default:leaves"','"default:leaves"'},
	}
})

minetest.register_abm(
	{nodenames = {"mesecons_blinkyplant:blinky_plant_off"},
	interval = leaves,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		--minetest.env:remove_node(pos)
		minetest.env:add_node(pos, {name="mesecons_blinkyplant:blinky_plant_on"})
		nodeupdate(pos)	
		mesecon:receptor_on(pos)
	end,
})

minetest.register_abm({
	nodenames = {"mesecons_blinkyplant:blinky_plant_on"},
	interval = BLINKY_PLANT_INTERVAL,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		--minetest.env:remove_node(pos)
		minetest.env:add_node(pos, {name="mesecons_blinkyplant:blinky_plant_off"})
		nodeupdate(pos)	
		mesecon:receptor_off(pos)
	end,
})

mesecon:add_receptor_node("mesecons_blinkyplant:blinky_plant_on")
mesecon:add_receptor_node_off("mesecons_blinkyplant:blinky_plant_off")
