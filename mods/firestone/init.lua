local makes_fire = true -- set to false if you want to light the fire yourself and extinguish it
local group

if makes_fire == true then
    group = {igniter=2, immortal, not_in_creative_inventory=1}
else
    group = {igniter=2, immortal, not_in_creative_inventory=1, dig_immediate=3}
end

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
	tile_images = {"firestone_firestone_top.png^firestone_embers.png", "firestone_firestone_bottom.png", "firestone_firestone.png"},
	groups = {igniter=2, crumbly=3},
	damage_per_second = 4,
	after_place_node = function(pos)
	    local t = {x=pos.x, y=pos.y+1, z=pos.z}
	    local n = minetest.env:get_node(t)
        if n.name == "air" and makes_fire == true then
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
	groups = group,
	drop = '',
	walkable = false,
	damage_per_second = 4,
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 },
	},
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
	groups = group,
	drop = '',
	walkable = false,
	damage_per_second = 4,
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 },
	},
})

minetest.register_abm({
    nodenames = {"firestone:firestone"},
	interval = 2,
	chance = 5,
	action = function(pos)
		local t = {x=pos.x, y=pos.y+1, z=pos.z}
	    local n = minetest.env:get_node(t)
        if n.name == "firestone:flame_low" then
		    minetest.env:set_node(t, {name="firestone:flame"})
		elseif n.name == "firestone:flame" then
		    minetest.env:set_node(t, {name="firestone:flame_low"})
		end
		if n.name == "fire:basic_flame" then
		    minetest.env:set_node(t, {name="firestone:flame"})
		end
	end,
})

--aximx51v chimney code

minetest.register_abm(
    {nodenames = {"firestone:chimney"},
    neighbors = {"group:igniter"},
    interval = 5.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
            p_bottom = {x=pos.x, y=pos.y-1, z=pos.z}
            n_bottom = minetest.env:get_node(p_bottom)
            local chimney_top = false
            local j = 1
            local node_param = minetest.registered_nodes[n_bottom.name]
            if node_param.groups.igniter then
                while chimney_top == false do
                    upper_pos = {x=pos.x, y=pos.y+j, z=pos.z}
                    upper_node = minetest.env:get_node(upper_pos)
                    if  upper_node.name == "firestone:chimney" then
                         j = j+1
                    elseif upper_node.name == "air" then
                        minetest.env:place_node(upper_pos,{name="firestone:smoke"})
                        chimney_top = true
                        elseif upper_node.name == "firestone:smoke" then
                        local old = minetest.env:get_meta(upper_pos)
                        old:set_int("age", 0)
                        chimney_top = true
                    elseif upper_node.name ~= "air" or upper_node.name ~= "firestone:chimney" or upper_node.name ~= "firestone:smoke" then
                        chimney_top = true
                    end
                end
        end
    end,
})

minetest.register_abm(
    {nodenames = {"firestone:smoke"},
    interval = 5.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local old = minetest.env:get_meta(pos)
        if old:get_int("age") == 1 then
            minetest.env:remove_node(pos)
        else
            old:set_int("age", 1)
        end
    end
})

minetest.register_craft({
    output = '"firestone:chimney" 4',
    recipe = {
        {'', 'default:cobble', ''},
        {'default:cobble', '', 'default:cobble'},
        {'', 'default:cobble', ''},
    }
})

minetest.register_node("firestone:chimney", {
    description = "WIP",
    drawtype = "nodebox",
        node_box = {type = "fixed",
            fixed = {
                {0.3125, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
                {-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5},
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.3125},
            },
        },
        selection_box = {
            type = "regular",
        },
    tiles ={"default_cobble.png"},
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = true,
    groups = {cracky=2},
})

minetest.register_node("firestone:smoke", {
    description = "smoke",
    drawtype = "plantlike", 
    tiles ={{
    name="firestone_smoke.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4.0},
    }},
    sunlight_propagates = true,
    groups = {not_in_creative_inventory=1},
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    light_source = 10,
    on_place_node = function(pos)
        local old = minetest.env:get_meta(pos)
        old:set_int("age", 0)
    end
})
