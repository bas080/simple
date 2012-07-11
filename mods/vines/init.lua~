print("[Vines] v1.0")

-- Nodes
minetest.register_node("vines:rope", {
    description = "Rope",
    walkable = false,
    climbable = true,
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_rope.png" },
    drawtype = "plantlike",
    inventory_image = "vines_rope_wield.png",
    groups = { snappy = 3},
    sounds =  default.node_sound_leaves_defaults(),
    on_place_node = function(pos)
        minetest.env:add_node(pos, "vines:ropes")
	end,
    
})

minetest.register_node("vines:ropes", {
    description = "Rope",
    walkable = false,
    climbable = true,
    sunlight_propagates = true,
    paramtype = "light",
    drops = "",
    tile_images = { "vines_rope.png" },
    drawtype = "plantlike",
    inventory_image = "vines_rope_wield.png",
    groups = { snappy = 3},
    sounds =  default.node_sound_leaves_defaults(),
    after_place_node = function(pos)
        yesh  = {x = pos.x, y= pos.y-1, z=pos.z}
		minetest.env:add_node(yesh, "vines:ropes")
	end,
})


minetest.register_node("vines:vine", {
    description = "Vine",
    walkable = false,
    climbable = true,
    drop = 'vines:vines',
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_vine.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

minetest.register_node("vines:vine_rotten", {
    description = "Rotten vine",
    walkable = false,
    climbable = true,
    drop = 'vines:vines',
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_vine_rotten.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine_rotten.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

--ABM
minetest.register_abm({
    nodenames = {"default:leaves", "growing_trees:leaves", "default:dirt_with_grass", },
    interval = 360,
    chance = 100,
    action = function(pos, node)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        if n.name =="air" then
            minetest.env:add_node(p, {name="vines:vine"})
        end
    end
})



minetest.register_abm({
    nodenames = {"vines:vine"},
    interval = 5,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        --remove if top node is removed
        if minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then 
            minetest.env:remove_node(pos)
        end
        
        --the second argument in the random function represents the average height
        if math.random(0,3)<1 then 
            minetest.env:add_node(pos, {name="vines:vine_rotten"})
        else
            if n.name =="air" then
                minetest.env:add_node(p, {name="vines:vine"})
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"vines:vine_rotten"},
    interval = 60,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        -- only remove if nothing is hangin on the bottom of it.
        if n.name ~="vines:vine" and n.name ~="vines:vine_rotten" then
            minetest.env:remove_node(pos)
        end
        
        if minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then 
            minetest.env:remove_node({x=pos.x, y=pos.y+1, z=pos.z})
        end
        
    end
})

minetest.register_abm({
    nodenames = {"default:dirt", "default:dirt_with_grass"},
    interval = 36000,
    chance = 10,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        --remove if top node is removed
        if  n.name == "air"
        and is_node_in_cube ({"vines:vine"}, pos, 3) then
            minetest.env:add_node(p, {name="vines:vine"})
        end 
    end
})

is_node_in_cube = function(nodenames, node_pos, radius)
    for x = node_pos.x - radius, node_pos.x + radius do
	for y = node_pos.y - radius, node_pos.y + radius do
	    for z = node_pos.z - radius, node_pos.z + radius do
		n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
		if (n == nil)
		    or (n.name == 'ignore')
		    or (table_contains(nodenames, n.name) == true) then
		    return true
		end
	    end
	end
    end

    return false
end

table_contains = function(t, v)
    for _, i in ipairs(t) do
	if (i == v) then
	    return true
	end
    end

    return false
end

-- craft rope
minetest.register_craft({
	output = 'vines:rope',
	recipe = {
		{'vines:vines', 'vines:vines', 'vines:vines'},
		{'vines:vines', 'vines:vines', 'vines:vines'},
		{'vines:vines', 'vines:vines', 'vines:vines'},
	}
})

minetest.register_craftitem("vines:vines", {
	description = "Vines",
	inventory_image = "vines_vine.png",
})


minetest.register_on_dignode(function(pos, node)
	if node.name=="vines:rope" then
		local np={x=pos.x, y=pos.y-1, z=pos.z}
		while minetest.env:get_node(np).name=="vines:rope" do
			minetest.env:remove_node(np)
			np={x=np.x, y=np.y-1, z=np.z}
		end
	end
end)



