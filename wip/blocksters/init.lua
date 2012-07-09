minetest.register_node("blocksters:eater", {
	description = "BOOOm",
	tile_images = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_abm(
    {nodenames = {"blocksters:eater"},
    interval = math.random(5),
    chance = 1,
    action = function(pos)

        local dx = {0, 0, 0, 0, 1, -1}
        local dy = {0, 0, 1, -1, 0, 0}
        local dz = {1, -1, 0, 0, 0, 0}    
            
        i = math.floor(math.random(1,6))

        local p = {x = pos.x + dx[i], y = pos.y + dy[i] , z = pos.z + dz[i]}
        local n = minetest.env:get_node(p)
        
        if n.name ~= "air" then
            minetest.env:add_node(p, {name="blocksters:eater"})
            minetest.env:remove_node(pos)
        end
               
              
    end
})
