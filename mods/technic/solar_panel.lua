minetest.register_node("technic:solar_panel", {
	tiles = {"technic_solar_panel_top.png", "technic_solar_panel_side.png", "technic_solar_panel_side.png",
		"technic_solar_panel_side.png", "technic_solar_panel_side.png", "technic_solar_panel_side.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
    	description="Solar Panel",
	active = false,
	technic_power_machine=1,
	internal_EU_buffer=0;
	internal_EU_buffer_size=1000;
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = true,	
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_float("technic_power_machine", 1)
		meta:set_float("internal_EU_buffer", 0)
		meta:set_float("internal_EU_buffer_size", 1000)

		meta:set_string("infotext", "Solar Panel")
		meta:set_float("active", false)
	end,
})

minetest.register_craft({
	output = 'technic:solar_panel 1',
	recipe = {
		{'technic:doped_silicon_wafer', 'technic:doped_silicon_wafer','technic:doped_silicon_wafer'},
		{'technic:doped_silicon_wafer', 'moreores:copper_ingot','technic:doped_silicon_wafer'},
		{'technic:doped_silicon_wafer', 'technic:doped_silicon_wafer','technic:doped_silicon_wafer'},

	}
})

minetest.register_abm(
	{nodenames = {"technic:solar_panel"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		
		local pos1={}
		pos1.y=pos.y+1
		pos1.x=pos.x
		pos1.z=pos.z

		local light = minetest.env:get_node_light(pos1, nil)
		local meta = minetest.env:get_meta(pos)
		if light == nil then light = 0 end
		if light >= 12 then
			meta:set_string("infotext", "Solar Panel is active ")
			meta:set_float("active",1)
			local internal_EU_buffer=meta:get_float("internal_EU_buffer")
			local internal_EU_buffer_size=meta:get_float("internal_EU_buffer_size")
			local charge_to_give=40+(pos1.y/250*40) -- make solar energy depending on height
			if charge_to_give<0 then charge_to_give=0 end
			if charge_to_give>160 then charge_to_give=160 end
			if internal_EU_buffer+charge_to_give>internal_EU_buffer_size then
			charge_to_give=internal_EU_buffer_size-internal_EU_buffer
			end
			internal_EU_buffer=internal_EU_buffer+charge_to_give
			meta:set_float("internal_EU_buffer",internal_EU_buffer)
			
		else
			meta:set_string("infotext", "Solar Panel is inactive");
			meta:set_float("active",0)
		end
	end,
}) 