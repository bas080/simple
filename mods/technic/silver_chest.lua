minetest.register_craft({
	output = 'technic:silver_chest 1',
	recipe = {
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		{'moreores:silver_ingot','technic:copper_chest','moreores:silver_ingot'},
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:silver_locked_chest 1',
	recipe = {
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		{'moreores:silver_ingot','technic:copper_locked_chest','moreores:silver_ingot'},
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:silver_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:silver_chest'},
	}
})

minetest.register_craftitem("technic:silver_chest", {
	description = "Silver Chest",
	stack_max = 99,
})
minetest.register_craftitem("technic:silver_locked_chest", {
	description = "Silver Locked Chest",
	stack_max = 99,
})

minetest.register_node("technic:silver_chest", {
	description = "Silver Chest",
	tiles = {"technic_silver_chest_top.png", "technic_silver_chest_top.png", "technic_silver_chest_side.png",
		"technic_silver_chest_side.png", "technic_silver_chest_side.png", "technic_silver_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Silver Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 11*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

	on_punch = function (pos, node, puncher)
	        local meta = minetest.env:get_meta(pos);
                meta:set_string("formspec", "hack:sign_text_input")
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
        local meta = minetest.env:get_meta(pos);
      		fields.text = fields.text or ""
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')

		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
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

minetest.register_node("technic:silver_locked_chest", {
	description = "Silver Locked Chest",
	tiles = {"technic_silver_chest_top.png", "technic_silver_chest_top.png", "technic_silver_chest_side.png",
		"technic_silver_chest_side.png", "technic_silver_chest_side.png", "technic_silver_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Silver Locked Chest (owned by "..
				meta:get_string("owner")..")")
	end,
on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Silver Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 11*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

	on_punch = function (pos, node, puncher)
	        local meta = minetest.env:get_meta(pos);
                meta:set_string("formspec", "hack:sign_text_input")
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
        local meta = minetest.env:get_meta(pos);
      		fields.text = fields.text or ""
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')

		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
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
