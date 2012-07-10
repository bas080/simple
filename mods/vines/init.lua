print("Vines loaded")
-- Nodes
minetest.register_node("vines:vine", {
    description = "Vine",
    walkable = false,
    climbable = true,
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
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_vine_rotten.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine_rotten.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

minetest.register_abm({
    nodenames = {"default:leaves"},
    interval = 90,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        
        
        if n.name =="air" and is_node_in_cube({"vines:vine", "vines:vine_rotten"}, p, 4)==false then
            minetest.env:add_node(p, {name="vines:vine"})
        end
    end
})

minetest.register_abm({
    nodenames = {"vines:vine"},
    interval = 10,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        
            
            if math.random(0,5)<1 then
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
    interval = 120,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
        
        local p = {x=pos.x, y=pos.y-1, z=pos.z}
        local n = minetest.env:get_node(p)
        
        if n.name ~="vines:vine" and n.name ~="vines:vine_rotten" then
            minetest.env:remove_node(pos)
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
