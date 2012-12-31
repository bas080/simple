minetest.register_craft({
	output = 'technic:copper_chest 1',
	recipe = {
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
		{'moreores:copper_ingot','technic:iron_chest','moreores:copper_ingot'},
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:copper_locked_chest 1',
	recipe = {
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
		{'moreores:copper_ingot','technic:iron_locked_chest','moreores:copper_ingot'},
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:copper_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:copper_chest'},
	}
})

minetest.register_craftitem("technic:copper_chest", {
	description = "Copper Chest",
	stack_max = 99,
})
minetest.register_craftitem("technic:copper_locked_chest", {
	description = "Copper Locked Chest",
	stack_max = 99,
})

minetest.register_node("technic:copper_chest", {
	description = "Copper Chest",
	tiles = {"technic_copper_chest_top.png", "technic_copper_chest_top.png", "technic_copper_chest_side.png",
		"technic_copper_chest_side.png", "technic_copper_chest_side.png", "technic_copper_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[10,9;]"..
				"list[current_name;main;0,0;10,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Copper Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 10*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})
  

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:copper_locked_chest", {
	description = "Copper Locked Chest",
	tiles = {"technic_copper_chest_top.png", "technic_copper_chest_top.png", "technic_copper_chest_side.png",
		"technic_copper_chest_side.png", "technic_copper_chest_side.png", "technic_copper_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Copper Locked Chest (owned by "..
				meta:get_string("owner")..")")
	end,
on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[10,9;]"..
				"list[current_name;main;0,0;10,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Copper Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 10*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
	end,
})
