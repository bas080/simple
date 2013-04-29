--[[
****
Stairs+
by Calinou
Licensed under the zlib/libpng license for code and CC BY-SA 3.0 Unported for textures, see LICENSE.txt for info.
****
--]]
-- Node will be called <modname>:stair_<subname>

function noncubic.register_stair(modname, subname, recipeitem, groups, images, description, drop)
		minetest.register_node(modname .. ":stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})

		minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

		minetest.register_node(modname .. ":stair_" .. subname .. "_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_half", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_half_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_half_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0, 0.5, 0.5},
				{-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0, 0.5, 0.5},
				{-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

		minetest.register_node(modname .. ":stair_" .. subname .. "_right_half", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.5, 0.5, 0, 0.5},
				{0, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.5, 0.5, 0, 0.5},
				{0, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_right_half_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})

		minetest.register_node(modname .. ":stair_" .. subname .. "_right_half_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{0, 0, -0.5, 0.5, 0.5, 0.5},
				{0, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0, 0, -0.5, 0.5, 0.5, 0.5},
				{0, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0, 0.5, 0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0, 0.5, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_wall_half", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_wall_half",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_wall_half_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_wall_half_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_wall_half",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_inner", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_inner",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_inner_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_outer", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_outer",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":stair_" .. subname.. "_outer_inverted")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_inner_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_inner",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node(modname .. ":stair_" .. subname .. "_outer_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":stair_" .. drop .. "_outer",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 8",
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 8",
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall 8",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, ""},
			{recipeitem, "", ""},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall 8",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall 2",
		recipe = {
			{modname .. ":stair_" .. subname, modname .. ":stair_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_inverted", modname .. ":stair_" .. subname .. "_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall"},
			{modname .. ":stair_" .. subname .. "_wall"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_inner 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom", modname .. ":stair_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_inner 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall_half"},
			{modname .. ":slab_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_outer 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":slab_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_half 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":panel_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_half_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half 1"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_half 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half_inverted 1"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_right_half 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half", modname .. ":stair_" .. subname .. "_half"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_half 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_right_half", modname .. ":stair_" .. subname .. "_right_half"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_right_half_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_right_half"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_right_half 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_right_half_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_half_inverted 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_right_half_inverted", modname .. ":stair_" .. subname .. "_right_half_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_right_half_inverted 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half_inverted", modname .. ":stair_" .. subname .. "_half_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_inner_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_inner"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_outer_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_outer"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_inner 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_inner_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_outer 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_outer_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall_half 2",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall_half"},
			{modname .. ":stair_" .. subname .. "_wall_half"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall_half_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall_half"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_wall_half 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_wall_half_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. "_inverted 1",
		recipe = {
			{modname .. ":stair_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 1",
		recipe = {
			{modname .. ":stair_" .. subname .. "_inverted"},
		},
	})
end

-- Node will be called <modname>slab_<subname>

function noncubic.register_slab(modname, subname, recipeitem, groups, images, description, drop)
	minetest.register_node(modname .. ":slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop,
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p1 = pointed_thing.above
			p1 = {x = p1.x, y = p1.y - 1, z = p1.z}
			local n1 = minetest.env:get_node(p1)
			if n1.name == modname .. ":slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname .. "_quarter" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_three_quarter")
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})

	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop,
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node(modname .. ":slab_" .. subname .. "_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_inverted",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p1 = pointed_thing.above
			p1 = {x = p1.x, y = p1.y + 1, z = p1.z}
			local n1 = minetest.env:get_node(p1)
			if n1.name == modname .. ":slab_" .. subname .. "_inverted" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname .. "_quarter_inverted" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_three_quarter_inverted")
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})
	
	minetest.register_node(modname .. ":slab_" .. subname .. "_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_wall",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node(modname .. ":slab_" .. subname .. "_quarter_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_wall",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node(modname .. ":slab_" .. subname .. "_three_quarter_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_wall",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(modname .. ":slab_" .. subname .. "_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_quarter",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p1 = pointed_thing.above
			p1 = {x = p1.x, y = p1.y - 1, z = p1.z}
			local n1 = minetest.env:get_node(p1)
			if n1.name == modname .. ":slab_" .. subname .. "_quarter" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_three_quarter")
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname .. "_three_quarter" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})

	minetest.register_node(modname .. ":slab_" .. subname .. "_quarter_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_quarter",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p1 = pointed_thing.above
			p1 = {x = p1.x, y = p1.y + 1, z = p1.z}
			local n1 = minetest.env:get_node(p1)
			if n1.name == modname .. ":slab_" .. subname .. "_quarter_inverted" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_inverted")
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname .. "_inverted" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_three_quarter_inverted")
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			if n1.name == modname .. ":slab_" .. subname .. "_three_quarter_inverted" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})

	minetest.register_node(modname .. ":slab_" .. subname .. "_three_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_three_quarter",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(modname .. ":slab_" .. subname .. "_three_quarter_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop .. "_three_quarter",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.25, -0.5, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.25, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. " 6",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_wall 6",
		recipe = {
			{recipeitem},
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. " 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_inverted"},
		},
	})
	
	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname},
			{modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname .. "_inverted"},
			{modname .. ":slab_" .. subname .. "_inverted"},
		},
	})
	
	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname .. "_wall", modname .. ":slab_" .. subname .. "_wall"},
		},
	})
	
	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname},
			{modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 6",
		recipe = {
			{modname .. ":slab_" .. subname, modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 6",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter"},
			{modname .. ":slab_" .. subname .. "_three_quarter"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter_wall 6",
		recipe = {
			{modname .. ":slab_" .. subname .. "_wall"},
			{modname .. ":slab_" .. subname .. "_wall"},
			{modname .. ":slab_" .. subname .. "_wall"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter_wall 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter_wall", modname .. ":slab_" .. subname .. "_quarter_wall", modname .. ":slab_" .. subname .. "_quarter_wall"},
		},
	})
	
end

-- Node will be called <modname>panel_<subname>

function noncubic.register_panel(modname, subname, recipeitem, groups, images, description, drop)
	minetest.register_node(modname .. ":panel_" .. subname .. "_bottom", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":panel_" .. drop .. "_bottom",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node(modname .. ":panel_" .. subname .. "_top", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":panel_" .. drop .. "_bottom",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node(modname .. ":panel_" .. subname .. "_vertical", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":panel_" .. drop .. "_bottom",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_bottom 8",
		recipe = {
			{recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_vertical 8",
		recipe = {
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_top 1",
		recipe = {
			{modname .. ":panel_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_bottom 1",
		recipe = {
			{modname .. ":panel_" .. subname .. "_top"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_vertical 2",
		recipe = {
			{modname .. ":panel_" .. subname .. "_bottom"},
			{modname .. ":panel_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. "_bottom 2",
		recipe = {
			{modname .. ":panel_" .. subname .. "_vertical", modname .. ":panel_" .. subname .. "_vertical"},
		},
	})
end

-- Node will be called <modname>micro_<subname>

function noncubic.register_micro(modname, subname, recipeitem, groups, images, description, drop)
	minetest.register_node(modname .. ":micro_" .. subname .. "_bottom", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":micro_" .. drop .. "_bottom",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	if p0.y-1 == p1.y then
		local fakestack = ItemStack(modname .. ":micro_" .. subname.. "_top")
		local ret = minetest.item_place(fakestack, placer, pointed_thing)
		if ret:is_empty() then
			itemstack:take_item()
			return itemstack
		end
	end
	
	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	})
	
	minetest.register_node(modname .. ":micro_" .. subname .. "_top", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":micro_" .. drop .. "_top",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_bottom 8",
		recipe = {
			{"default:stick"},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_top 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_bottom 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_top"},
		},
	})
end

-- Nodes will be called <modname>:{stair,slab,panel,micro}_<subname>
function noncubic.register_stair_and_slab_and_panel_and_micro(modname, subname, recipeitem, groups, images, desc_stair, desc_slab, desc_panel, desc_micro, drop)
	noncubic.register_stair(modname, subname, recipeitem, groups, images, desc_stair, drop)
	noncubic.register_slab(modname, subname, recipeitem, groups, images, desc_slab, drop)
	noncubic.register_panel(modname, subname, recipeitem, groups, images, desc_panel, drop)
	noncubic.register_micro(modname, subname, recipeitem, groups, images, desc_micro, drop)
end
