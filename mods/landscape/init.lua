local remove_full_grass = false  --set "true" to remove all full_grass_blocks

minetest.register_node("landscape:full_grass_block", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

local function get_type(pos)  --1 for left, 2 for right, 3 for behind, 4 for front
	if minetest.registered_nodes[minetest.env:get_node({x=pos.x+1, y=pos.y, z=pos.z}).name].walkable == false then
		return 1
	elseif minetest.registered_nodes[minetest.env:get_node({x=pos.x-1, y=pos.y, z=pos.z}).name].walkable == false then
		return 2
	elseif minetest.registered_nodes[minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z+1}).name].walkable == false then
		return 3
	elseif minetest.registered_nodes[minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z-1}).name].walkable == false then
		return 4
	else
		return 0
	end
end

local function is_edge(pos)
	local l1 = {x=pos.x-1, y=pos.y, z=pos.z}
	local l2 = {x=pos.x, y=pos.y, z=pos.z-1}
	local r1 = {x=pos.x+1, y=pos.y, z=pos.z}
	local r2 = {x=pos.x, y=pos.y, z=pos.z+1}
	if minetest.registered_nodes[minetest.env:get_node(l1).name].walkable == false or
	minetest.registered_nodes[minetest.env:get_node(l2).name].walkable == false or
	minetest.registered_nodes[minetest.env:get_node(r1).name].walkable == false or
	minetest.registered_nodes[minetest.env:get_node(r2).name].walkable == false then
		return true
	end
	
end

local function check(pos)
	if string.find(minetest.env:get_node(pos).name, "_grass") then
		return true
	else
		return false
	end
end


if remove_full_grass == false then
	minetest.register_abm({
		nodenames = {"default:dirt_with_grass"},
		--neighbors = {"default:dirt_with_grass", "landscape:full_grass_block"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local under = {x=pos.x, y=pos.y-1, z=pos.z}
			local above = {x=pos.x, y=pos.y+1, z=pos.z}
			local under_front = {x=pos.x+1, y=pos.y-1, z=pos.z}
			local under_front2 = {x=pos.x, y=pos.y-1, z=pos.z+1}
			local under_back = {x=pos.x-1, y=pos.y-1, z=pos.z}
			local under_back2 = {x=pos.x, y=pos.y-1, z=pos.z-1}
			if minetest.registered_nodes[minetest.env:get_node(above).name].walkable == false then
			if get_type(pos) ~= 0 then
				local typ = get_type(pos)
				local ok = false
				if typ == 1 then
					ok = check(under_front)
				elseif typ == 2 then
					ok = check(under_back)
				elseif typ == 3 then
					ok = check(under_front2)
				elseif typ == 4 then
					ok = check(under_back2)
				end
				if ok then
					if minetest.env:get_node(under).name == "default:dirt" then 
						if not is_edge(under) then
					--IF GRAS UNTEN-DAVOR tthen....
							local tmp_node3 = {name="landscape:full_grass_block"}
							minetest.env:set_node(pos, tmp_node3)	
						end
					else
						local tmp_node3 = {name="landscape:full_grass_block"}
						minetest.env:set_node(pos, tmp_node3)
					end
				end
			end
			end
			
		end
	})

	--remove full grass when block is placed above
	minetest.register_abm({
		nodenames = {"landscape:full_grass_block"},
		interval = 2.0,
		chance = 20,
		action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.registered_nodes[minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name].walkable == true then
			local tmp_node3 = {name="default:dirt"}
			minetest.env:set_node(pos, tmp_node3)
		end
	end
	})
else
	minetest.register_abm({
		nodenames = {"landscape:full_grass_block"},
		interval = 1.0,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local tmp_node3 = {name="default:dirt_with_grass"}
			minetest.env:set_node(pos, tmp_node3)
		end
	})
end
