-- init.lua
-- candles minetest mod, by darkrose
-- Copyright (C) Lisa Milne 2013 <lisa@ltmnet.com>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>

local candles = {};

candles.types = {
	{
		unlit = 'candles:candle',
		lit = 'candles:candle_lit',
		name = 'Candle',
		ingot = nil,
		image = 'candles_candle'
	},
	{
		unlit = 'candles:candle_wall_steel',
		lit = 'candles:candle_wall_steel_lit',
		name = 'Steel Wall-Mount Candle',
		ingot = 'default:steel_ingot',
		image = 'candles_candle_steel'
	},
	{
		unlit = 'candles:candle_wall_copper',
		lit = 'candles:candle_wall_copper_lit',
		name = 'Copper Wall-Mount Candle',
		ingot = 'moreores:copper_ingot',
		image = 'candles_candle_copper'
	},
	{
		unlit = 'candles:candle_wall_silver',
		lit = 'candles:candle_wall_silver_lit',
		name = 'Silver Wall-Mount Candle',
		ingot = 'moreores:silver_ingot',
		image = 'candles_candle_silver'
	},
	{
		unlit = 'candles:candle_wall_gold',
		lit = 'candles:candle_wall_gold_lit',
		name = 'Gold Wall-Mount Candle',
		ingot = 'moreores:gold_ingot',
		image = 'candles_candle_gold'
	},
	{
		unlit = 'candles:candle_wall_bronze',
		lit = 'candles:candle_wall_bronze_lit',
		name = 'Bronze Wall-Mount Candle',
		ingot = 'moreores:bronze_ingot',
		image = 'candles_candle_bronze'
	},
	{
		unlit = 'candles:candelabra_steel',
		lit = 'candles:candelabra_steel_lit',
		name = 'Steel Candelebra',
		ingot = 'default:steel_ingot',
		image = 'candles_candelabra_steel'
	},
	{
		unlit = 'candles:candelabra_copper',
		lit = 'candles:candelabra_copper_lit',
		name = 'Copper Candelebra',
		ingot = 'moreores:copper_ingot',
		image = 'candles_candelabra_copper'
	},
	{
		unlit = 'candles:candelabra_silver',
		lit = 'candles:candelabra_silver_lit',
		name = 'Silver Candelebra',
		ingot = 'moreores:silver_ingot',
		image = 'candles_candelabra_silver'
	},
	{
		unlit = 'candles:candelabra_gold',
		lit = 'candles:candelabra_gold_lit',
		name = 'Gold Candelebra',
		ingot = 'moreores:gold_ingot',
		image = 'candles_candelabra_gold'
	},
	{
		unlit = 'candles:candelabra_bronze',
		lit = 'candles:candelabra_bronze_lit',
		name = 'Bronze Candelebra',
		ingot = 'moreores:bronze_ingot',
		image = 'candles_candelabra_bronze'
	},
}

candles.find_lit = function(name)
	for i,n in ipairs(candles.types) do
		if n.unlit == name then
			return n.lit
		end
	end
	return nil
end

candles.find_unlit = function(name)
	for i,n in ipairs(candles.types) do
		if n.lit == name then
			return n.unlit
		end
	end
	return nil
end

candles.light = function(pos, node, puncher)
	if not puncher or not node then
		return
	end
	local wield = puncher:get_wielded_item()
	if not wield then
		return
	end
	wield = wield:get_name()
	if wield and wield == 'default:torch' then
		local litname = candles.find_lit(node.name)
		minetest.env:add_node(pos,{name=litname, param1=node.param1, param2=node.param2})
	end
end

candles.snuff = function(pos, node, puncher)
	if not puncher or not node then
		return
	end
	local wield = puncher:get_wielded_item()
	if not wield then
		return
	end
	wield = wield:get_name()
	if not wield or wield ~= 'default:torch' then
		local unlitname = candles.find_unlit(node.name)
		minetest.env:add_node(pos,{name=unlitname, param1=node.param1, param2=node.param2})
	end
end

candles.collect = function(pos, node, puncher)
	local meta = minetest.env:get_meta(pos)
	local angry = meta:get_string('angry')
	local comb = meta:get_int('comb')
	if ( angry and angry == 'true' ) or comb < 1 then
		local health = puncher:get_hp()
		puncher:set_hp(health-2)
	else
		comb = comb-1
		meta:set_int('comb',comb)
		puncher:get_inventory():add_item('main', 'candles:comb')
	end
	if comb < 1 then
		meta:set_string('angry','true')
	end
	if node.name == 'candles:hive' then
		if comb < 1 then
			meta:set_string('infotext','Bee Hive: Angry')
		else
			meta:set_string('infotext','Bee Hive: Busy');
		end
	end
	local tmr = minetest.env:get_node_timer(pos)
	tmr:start(300)
end

candles.create_wall = function(ctype)
	minetest.register_node(ctype.unlit, {
		description = ctype.name,
		tile_images = {ctype.image.."_top.png",ctype.image.."_top.png",ctype.image..".png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {crumbly=3,oddly_breakable_by_hand=1},
		on_punch = candles.light,
		sunlight_propagates = true,
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
				-- x,y,z,x,y,z
				-- body
				{0.11, -0.3, -0.07, 0.27, 0.2, 0.07},
				-- wick
				{0.18, 0.2, -0.02, 0.22, 0.3, 0.02},
				-- holder
				{0.1, -0.4, -0.1, 0.3, -0.27, 0.1},
				{0.1, -0.35, -0.05, 0.5, -0.3, 0.05},
				{0.45, -0.40, -0.12, 0.5, -0.25, 0.12},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {0.05, -0.45, -0.2, 0.5, 0.3, 0.15}
		},
		on_place = function(itemstack, placer, pointed_thing)
			local above = pointed_thing.above
			local under = pointed_thing.under
			local dir = {x = under.x - above.x,
				     y = under.y - above.y,
				     z = under.z - above.z}

			local wdir = minetest.dir_to_wallmounted(dir)
			local fdir = minetest.dir_to_facedir(dir)

			if wdir == 0 or wdir == 1 then
				return itemstack
			else
				fdir = fdir-1
				if fdir < 0 then
					fdir = 3
				end
				minetest.env:add_node(above, {name = itemstack:get_name(), param2 = fdir})
				itemstack:take_item()
				return itemstack
			end
		end
	})

	minetest.register_node(ctype.lit, {
		description = ctype.name,
		tile_images = {ctype.image.."_top.png",ctype.image.."_top.png",ctype.image.."_lit.png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {},
		on_punch = candles.snuff,
		sunlight_propagates = true,
		walkable = false,
		light_source = 8,
		drop = ctype.unlit,
		node_box = {
			type = "fixed",
			fixed = {
				-- x,y,z,x,y,z
				-- body
				{0.11, -0.3, -0.07, 0.27, 0.2, 0.07},
				-- wick
				{0.18, 0.2, -0.02, 0.22, 0.42, 0.02},
				-- flame
				{0.14, 0.25, -0.06, 0.26, 0.3, 0.06},
				{0.16, 0.3, -0.04, 0.24, 0.37, 0.04},
				-- holder
				{0.1, -0.4, -0.1, 0.3, -0.27, 0.1},
				{0.1, -0.35, -0.05, 0.5, -0.3, 0.05},
				{0.45, -0.40, -0.12, 0.5, -0.25, 0.12},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {0.05, -0.45, -0.2, 0.5, 0.45, 0.15}
		},
		can_dig = function(pos,player)
			return false
		end,
	})
	minetest.register_craft({
		output = ctype.unlit,
		recipe = {
			{'candles:candle'},
			{ctype.ingot},
		}
	})
end

candles.create_candelabra = function(ctype)
	minetest.register_node(ctype.unlit, {
		description = ctype.name,
		tile_images = {ctype.image.."_top.png",ctype.image.."_top.png",ctype.image..".png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {crumbly=3,oddly_breakable_by_hand=1},
		on_punch = candles.light,
		sunlight_propagates = true,
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
				-- x,y,z,x,y,z
				-- body
				{-0.08, -0.3, -0.48, 0.08, 0.2, -0.32},
				{-0.08, -0.3, -0.08, 0.08, 0.2, 0.08},
				{-0.08, -0.3, 0.32, 0.08, 0.2, 0.48},
				-- wick
				{-0.02, 0.2, -0.42, 0.02, 0.3, -0.38},
				{-0.02, 0.2, -0.02, 0.02, 0.3, 0.02},
				{-0.02, 0.2, 0.38, 0.02, 0.3, 0.42},
				-- holder
				{-0.1, -0.27, -0.5, 0.1, -0.2, -0.3},
				{-0.1, -0.27, -0.1, 0.1, -0.2, 0.1},
				{-0.1, -0.27, 0.3, 0.1, -0.2, 0.5},
				-- stand
				{-0.05, -0.32, -0.45, 0.05, -0.27, 0.45},
				-- base
				{-0.05, -0.45, -0.05, 0.05, -0.3, 0.05},
				{-0.1, -0.49, -0.1, 0.1, -0.45, 0.1},
				{-0.15, -0.5, -0.15, 0.15, -0.49, 0.15},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			local above = pointed_thing.above
			local under = pointed_thing.under
			local dir = {x = under.x - above.x,
				     y = under.y - above.y,
				     z = under.z - above.z}

			local wdir = minetest.dir_to_wallmounted(dir)
			local fdir = minetest.dir_to_facedir(dir)

			if wdir == 1 then
				minetest.env:add_node(above, {name = itemstack:get_name(), param2 = fdir})
				itemstack:take_item()
			end
			return itemstack
		end
	})

	minetest.register_node(ctype.lit, {
		description = ctype.name,
		tile_images = {ctype.image.."_top.png",ctype.image.."_top.png",ctype.image.."_lit.png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {},
		on_punch = candles.snuff,
		sunlight_propagates = true,
		walkable = false,
		light_source = 12,
		drop = ctype.unlit,
		node_box = {
			type = "fixed",
			fixed = {
				-- x,y,z,x,y,z
				-- body
				{-0.08, -0.3, -0.48, 0.08, 0.2, -0.32},
				{-0.08, -0.3, -0.08, 0.08, 0.2, 0.08},
				{-0.08, -0.3, 0.32, 0.08, 0.2, 0.48},
				-- wick
				{-0.02, 0.2, -0.42, 0.02, 0.45, -0.38},
				{-0.02, 0.2, -0.02, 0.02, 0.45, 0.02},
				{-0.02, 0.2, 0.38, 0.02, 0.45, 0.42},
				-- flame
				{-0.06, 0.25, -0.46, 0.06, 0.3, -0.34},
				{-0.04, 0.3, -0.44, 0.04, 0.37, -0.36},
				{-0.06, 0.25, -0.06, 0.06, 0.3, 0.06},
				{-0.04, 0.3, -0.04, 0.04, 0.37, 0.04},
				{-0.06, 0.25, 0.34, 0.06, 0.3, 0.46},
				{-0.04, 0.3, 0.36, 0.04, 0.37, 0.44},
				-- holder
				{-0.1, -0.27, -0.5, 0.1, -0.2, -0.3},
				{-0.1, -0.27, -0.1, 0.1, -0.2, 0.1},
				{-0.1, -0.27, 0.3, 0.1, -0.2, 0.5},
				-- stand
				{-0.05, -0.32, -0.45, 0.05, -0.27, 0.45},
				-- base
				{-0.05, -0.45, -0.05, 0.05, -0.3, 0.05},
				{-0.1, -0.49, -0.1, 0.1, -0.45, 0.1},
				{-0.15, -0.5, -0.15, 0.15, -0.49, 0.15},
			},
		},
		can_dig = function(pos,player)
			return false
		end,
	})
	minetest.register_craft({
		output = ctype.unlit,
		recipe = {
			{'candles:candle','candles:candle','candles:candle'},
			{ctype.ingot,ctype.ingot,ctype.ingot},
		}
	})
end

minetest.register_node("candles:candle", {
	description = "Candle",
	tile_images = {"candles_candle_top.png","candles_candle.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {crumbly=3,oddly_breakable_by_hand=1},
	on_punch = candles.light,
	sunlight_propagates = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			-- x,y,z,x,y,z
			-- body
			{-0.08, -0.5, -0.08, 0.08, 0.0, 0.08},
			-- wick
			{-0.02, 0.0, -0.02, 0.02, 0.1, 0.02},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.12, 0.1}
	},
	on_place = function(itemstack, placer, pointed_thing)
		local above = pointed_thing.above
		local under = pointed_thing.under
		local dir = {x = under.x - above.x,
			     y = under.y - above.y,
			     z = under.z - above.z}

		local wdir = minetest.dir_to_wallmounted(dir)

		if wdir == 1 then
			minetest.env:add_node(above, {name = 'candles:candle'})
			itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_node("candles:candle_lit", {
	description = "Candle",
	tile_images = {"candles_candle_top.png","candles_candle_lit.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {},
	on_punch = candles.snuff,
	sunlight_propagates = true,
	walkable = false,
	light_source = 8,
	drop = 'candles:candle',
	node_box = {
		type = "fixed",
		fixed = {
			-- x,y,z,x,y,z
			-- body
			{-0.08, -0.5, -0.08, 0.08, 0.0, 0.08},
			-- wick
			{-0.02, 0.0, -0.02, 0.02, 0.25, 0.02},
			-- flame
			{-0.06, 0.1, -0.06, 0.06, 0.15, 0.06},
			{-0.04, 0.15, -0.04, 0.04, 0.22, 0.04},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.37, 0.1}
	},
	can_dig = function(pos,player)
		return false
	end,
})

minetest.register_node("candles:hive_wild", {
	description = "Wild Bee Hive",
	tile_images = {"candles_hive_wild.png"},
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = 'wallmounted',
	groups = {attached_node=1},
	on_punch = candles.collect,
	can_dig = function(pos,player)
		return false
	end,
	on_place = function(itemstack, placer, pointed_thing)
		minetest.env:add_node(pointed_thing.above, {name = itemstack:get_name(), param2 = 0})
		itemstack:take_item()
		return itemstack
	end,
	on_timer = function(pos,elapsed)
		local meta = minetest.env:get_meta(pos)
		local angry = meta:get_string('angry')
		if angry and angry == 'true' then
			meta:set_string('angry','')
			meta:set_int('comb',1)
		else
			local c = meta:get_int('comb')
			if c == 3 then
				minetest.env:add_node(pos,{name='default:apple'})
				return false
			elseif c == 0 then
				meta:set_string('angry','true')
			else
				meta:set_int('comb',c+1)
			end
		end
		return true
	end,
	on_construct = function(pos)
		local tmr = minetest.env:get_node_timer(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string('angry','true')
		tmr:start(300)
	end
})

minetest.register_node("candles:hive", {
	description = "Bee Hive",
	tile_images = {"candles_hive_top.png","candles_hive_bottom.png","candles_hive.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	on_punch = candles.collect,
	node_box = {
		type = "fixed",
		fixed = {
			-- x,y,z,x,y,z
			-- body
			{-0.5, -0.1, -0.5, 0.5, 0.5, 0.5},
			-- legs
			{-0.4, -0.5, -0.4, -0.3, 0.0, -0.3},
			{0.3, -0.5, -0.4, 0.4, 0.0, -0.3},
			{-0.4, -0.5, 0.3, -0.3, 0.0, 0.4},
			{0.3, -0.5, 0.3, 0.4, 0.0, 0.4},
		},
	},
	on_timer = function(pos,elapsed)
		local meta = minetest.env:get_meta(pos)
		local angry = meta:get_string('angry')
		if angry and angry == 'true' then
			meta:set_string('angry','')
			meta:set_string('infotext','Bee Hive: Busy');
			meta:set_int('comb',1)
		else
			local c = meta:get_int('comb')
			if c == 0 then
				meta:set_string('angry','true')
				meta:set_string('infotext','Bee Hive: Angry');
			else
				meta:set_int('comb',c+2)
				meta:set_string('infotext','Bee Hive: Busy');
			end
		end
		return true
	end,
	on_construct = function(pos)
		local tmr = minetest.env:get_node_timer(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string('angry','true')
		meta:set_string('infotext','Bee Hive: Angry');
		tmr:start(300)
	end
})

minetest.register_node("candles:hive_empty", {
	description = "Bee Hive",
	tile_images = {"candles_hive_top.png","candles_hive_bottom.png","candles_hive.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			-- x,y,z,x,y,z
			-- body
			{-0.5, -0.1, -0.5, 0.5, 0.5, 0.5},
			-- legs
			{-0.4, -0.5, -0.4, -0.3, 0.0, -0.3},
			{0.3, -0.5, -0.4, 0.4, 0.0, -0.3},
			{-0.4, -0.5, 0.3, -0.3, 0.0, 0.4},
			{0.3, -0.5, 0.3, 0.4, 0.0, 0.4},
		},
	},
	on_timer = function(pos,elapsed)
		minetest.env:add_node(pos,{name='candles:hive'})
		return false
	end,
	on_construct = function(pos)
		local tmr = minetest.env:get_node_timer(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string('infotext','Bee Hive: Empty');
		tmr:start(300)
	end
})

minetest.register_craftitem("candles:wax", {
	description = "Beeswax",
	inventory_image = "candles_wax.png",
})

minetest.register_craftitem("candles:honey", {
	description = "Honey",
	inventory_image = "candles_honey.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("candles:comb", {
	description = "Honey Comb",
	inventory_image = "candles_comb.png",
})

minetest.register_craft({
	output = 'candles:candle',
	recipe = {
		{'candles:wax','farming:string','candles:wax'},
	}
})

minetest.register_craft({
	output = 'candles:honey 2',
	recipe = {
		{'candles:comb'},
	}
})

minetest.register_craft({
	type = 'cooking',
	output = 'candles:wax 2',
	recipe = 'candles:comb'
})

minetest.register_craft({
	output = 'candles:hive',
	recipe = {
		{'default:wood','default:wood','default:wood'},
		{'default:stick','candles:hive_wild','default:stick'},
		{'default:stick','default:wood','default:stick'},
	}
})

minetest.register_craft({
	output = 'candles:hive_empty',
	recipe = {
		{'default:wood','default:wood','default:wood'},
		{'default:stick','default:paper','default:stick'},
		{'default:stick','default:wood','default:stick'},
	}
})

for i,n in ipairs(candles.types) do
	if n.ingot then
		if string.find(n.unlit,'candelabra') then
			candles.create_candelabra(n)
		else
			candles.create_wall(n)
		end
	end
end

minetest.register_abm({
	nodenames = 'default:apple',
	neighbors = 'default:leaves',
	interval = 1200,
	chance = 30,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local abv = minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z})
		if not abv or abv.name ~= 'default:leaves' then
			return nil
		end
		minetest.env:add_node(pos,{name='candles:hive_wild', param2 = 0})
	end
})
