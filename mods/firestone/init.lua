minetest.register_alias("firestone", "firestone:firestone")

minetest.register_craft({
	output = '"firestone:firestone" 1',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:torch', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_node("firestone:firestone", {
	description = "Fire node",
	tile_images = {"firestone_firestone_top.png^firestone_embers.png", "default_wood.png", "firestone_firestone.png"},
	groups = {igniter=2, crumbly=3},
	damage_per_second = 4,
	
	after_place_node = function(pos)
	    local t = {x=pos.x, y=pos.y+1, z=pos.z}
	    local n = minetest.env:get_node(t)
        if n.name == "air" then
		    minetest.env:add_node(t, {name="firestone:flame"})
		end
	end,
	
	after_dig_node = function(pos)
		local t = {x=pos.x, y=pos.y+1, z=pos.z}
	    local n = minetest.env:get_node(t)
        if n.name == "firestone:flame" or n.name == "firestone:flame_low" then
		    minetest.env:remove_node(t)
		end
	end,
	
})

minetest.register_node("firestone:flame", {
	description = "Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {igniter=2, immortal, not_in_creative_inventory=1},
	drop = '',
	walkable = false,
	damage_per_second = 4,
})

minetest.register_node("firestone:flame_low", {
	description = "Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 12,
	groups = {igniter=2, immortal, not_in_creative_inventory=1},
	drop = '',
	walkable = false,
	damage_per_second = 4,
})

minetest.register_abm({
    nodenames = {"firestone:firestone"},
	interval = 2,
	chance = 10,
	action = function(pos)
		local t = {x=pos.x, y=pos.y+1, z=pos.z}
	    local n = minetest.env:get_node(t)
        if n.name == "firestone:flame_low" then
		    minetest.env:set_node(t, {name="firestone:flame"})
		elseif n.name == "firestone:flame" then
		    minetest.env:set_node(t, {name="firestone:flame_low"})
		end
		
		
	end,

})
