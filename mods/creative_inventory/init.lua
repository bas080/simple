invStart = 0
list = {}
local function updateInventory(meta, start)
	local node
	local name
	local count = 0
	local inv = meta:get_inventory()
	if start < 0 then
		start = 0
	end
	if start > #list then
		local remain = #list%40
		start = #list-remain
	end
	if not inv:is_empty("main") then
		for var=0,inv:get_size("main"),1 do
			inv:set_stack("main", var, nil)
		end
	end
	for node,name in pairs(list) do
		if count >= start then
			inv:add_item("main", name)
		end
		count = count+1
	end
	invStart = start
end
minetest.register_node("creative_inventory:creativeChest", {
	description = "Creative Chest",
	tile_images = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[14,9;]"..
				"list[current_name;main;0,0;14,4;]"..
				"list[current_name;previous;6,4;1,1;]"..
				"list[current_name;next;7,4;1,1;]"..
				"list[current_player;main;3,5;8,4;]")
		meta:set_string("infotext", "Creative Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 14*4)
		inv:set_size("previous", 1)
		inv:set_size("next", 1)
		updateInventory(meta, invStart)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return true
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		if to_list == "previous" then
			updateInventory(meta, invStart-inv:get_size("main"))
		end
		if to_list == "next" then
			updateInventory(meta, invStart+inv:get_size("main"))
		end
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    	on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    	on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})
minetest.register_on_joinplayer(function(obj)
	if minetest.setting_get('creative_mode') == '1' then
		minetest.add_to_creative_inventory('creative_inventory:creativeChest')
		local node
		for node in pairs(minetest.registered_items) do
			table.insert(list, {name = node})
		end
		table.sort(list, function(a,b)
			return a.name < b.name
		end)
	end
end)

minetest.register_craft({
	output = 'creative_inventory:creativeChest 1',
	recipe = {
		{'default:leaves'},
	}
})


