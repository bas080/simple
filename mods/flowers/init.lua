--[[
-- Flowers mod by ironzorg
--]]

math.randomseed(os.time())

local DEBUG = 0

local FLOWERS = {
	"rose",
	"dandelion_yellow",
	"dandelion_white",
	"tulip",
	"viola",
}

local MAX_RATIO = 2000
local GROWING_DELAY = 3600

-- Local Functions
local dbg = function(s)
	if DEBUG == 1 then
		print('[FLOWERS] ' .. s)
	end
end

local table_contains = function(t, v)
	for _, i in ipairs(t) do
		if (i == v) then
			return true
		end
	end

	return false
end

local is_node_in_cube = function(nodenames, node_pos, radius)
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

local grow_blocks_on_surfaces = function(growdelay, grownames, surfaces)
	for _, surface in ipairs(surfaces) do
		minetest.register_abm({
			nodenames = { surface.name },
			interval = growdelay,
			chance = 30,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local p_top = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}
				local n_top = minetest.env:get_node(p_top)
				local rnd = math.random(1, MAX_RATIO)

				if (MAX_RATIO - surface.chance < rnd) then
					local flower_in_range = is_node_in_cube(grownames, p_top, surface.spacing)
					if (n_top.name == "air") and (flower_in_range == false) then
						local nnode = grownames[math.random(1, #grownames)]
						dbg('Adding node ' .. nnode .. ' ('
							.. pos.x .. ', '
							.. pos.y .. ', '
							.. pos.z .. ')')
						minetest.env:add_node(p_top, { name = nnode })
					end
				end
			end
		})
	end
end

-- Nodes
for _, color in ipairs(FLOWERS) do
	local fname = 'flower_' .. color

	minetest.register_node('flowers:' .. fname, {
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tile_images = { fname .. '.png' },
		inventory_image = fname .. '.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		material = minetest.digprop_constanttime(0.0),
		furnace_burntime = 1,
	})
end

minetest.register_node('flowers:flower_waterlily', {
	drawtype = 'raillike',
	tile_images = { 'flower_waterlily.png', },
	inventory_image = 'flower_waterlily.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(0.0),
})

-- Items
minetest.register_craftitem('flowers:flower_pot', {
	drawtype = 'plantlike',
	image = 'flower_pot.png',
	stack_max = 1,
	visual_scale = 1.0,
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	material = minetest.digprop_constanttime(0.5),
})

for _, color in ipairs(FLOWERS) do
	local fname = 'flower_' .. color
	local pname = fname .. '_pot'

	minetest.register_craftitem('flowers:' .. pname, {
		drawtype = 'plantlike',
		image = pname .. '.png',
		stack_max = 1,
		visual_scale = 1.2,
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		material = minetest.digprop_constanttime(1.0),
	})
end

-- Crafts
minetest.register_craft({
	output = 'CraftItem "flowers:flower_pot" 1',
	recipe = {
		{'craft "clay_brick" 1', '', 'craft "clay_brick" 1'},
		{'', 'craft "clay_brick" 1', ''},
	}
})

for _, color in ipairs(FLOWERS) do
	local fname = 'flowers:flower_' .. color
	local pname = fname .. '_pot'

	minetest.register_craft({
		output = 'CraftItem "' .. pname .. '" 1',
		recipe = {
			{'NodeItem "' .. fname .. '" 1'},
			{'CraftItem "flowers:flower_pot" 1'},
		}
	})
end

-- Make it grow !
grow_blocks_on_surfaces(GROWING_DELAY * 2, {
	"flowers:flower_rose",
	"flowers:flower_dandelion_white",
	"flowers:flower_viola",
	}, {
	{name = "dirt_with_grass", chance = 4, spacing = 15},
})

grow_blocks_on_surfaces(GROWING_DELAY, {
	"flowers:flower_dandelion_yellow",
	"flowers:flower_tulip",
	}, {
	{name = "dirt_with_grass", chance = 2, spacing = 10},
})

grow_blocks_on_surfaces(GROWING_DELAY / 2, {
	"flowers:flower_waterlily",
	}, {
	{name = "water_source", chance = 1, spacing = 15},
})
