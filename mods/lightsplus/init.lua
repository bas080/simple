-- LIGHTS+
--Mod adding simple lights by qwrwed.

--experimental Super Light, not working - don't know max possible value of light_source and they aren't converting.

--[[minetest.register_node("lightsplus:super_light", {
	description = "Super Light",
	tiles = {"lightsplus_light.png"},
	groups = {choppy=3,cracky=2},
})

minetest.register_node("lightsplus:super_light_on", {
	description = "Active Super Light",
	tile_images = {"lightsplus_light.png"},
	drop = 'lightsplus:super_light',
	light_source = 20,
	groups = {choppy=3,cracky=3,not_in_creative_inventory=1},
})
minetest.register_craft({
	output = '"lightsplus:super_light"',
	recipe = {
		{'lightsplus:light', 'lightsplus:light', 'lightsplus:light'},
		{'lightsplus:light', 'lightsplus:light', 'lightsplus:light'},
		{'lightsplus:light', 'lightsplus:light', 'lightsplus:light'},
	}
})

local on_light_puncher = function (pos, node, puncher)
  if node.name == 'lightsplus:super_light' then
    minetest.env:add_node(pos, {name="lightsplus:super_light_on"})
    nodeupdate(pos)
  elseif node.name == 'lightsplus:super_light_on' then
	minetest.env:add_node(pos, {name="lightsplus:super_light",})
    nodeupdate(pos)
  end
end]]

-- Normal Light
minetest.register_node("lightsplus:light", {
	description = "Light",
	tiles = {"lightsplus_light.png"},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("lightsplus:light_on", {
	description = "Active Light",
	tile_images = {"lightsplus_light.png"},
	drop = 'lightsplus:light',
	light_source = 15,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})
-- Slab Light
minetest.register_node("lightsplus:slab_light", {
	description = "Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("lightsplus:slab_light_on", {
	description = "Active Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	drop = 'lightsplus:slab_light',
	light_source = 15,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=2},
})

-- Wall Slab Light
minetest.register_node("lightsplus:slab_light_wall", {
	description = "Wall Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
	},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("lightsplus:slab_light_wall_on", {
	description = "Active Wall Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
	},
	drop = 'lightsplus:slab_light',
	light_source = 15,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=2},
})
--Inverted Slab Light
minetest.register_node("lightsplus:slab_light_inv", {
	description = "Inverted Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
	},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("lightsplus:slab_light_inv_on", {
	description = "Active Inverted Slab Light",
	tile_images = {"lightsplus_light.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
	},
	drop = 'lightsplus:slab_light_inv',
	light_source = 15,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=2},
})
--Crafts
--Light
minetest.register_craft({
	output = '"lightsplus:light" 10',
	recipe = {
		{'default:glass', 'default:glass', 'default:glass'},
		{'default:torch', 'default:torch', 'default:torch'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})
--Slab Light
minetest.register_craft({
	output = '"lightsplus:slab_light" 6',
	recipe = {
		{'lightsplus:light', 'lightsplus:light', 'lightsplus:light'},
	}
})
--Back to a Light
minetest.register_craft({
	output = '"lightsplus:light"',
	recipe = {
		{'lightsplus:slab_light'},
		{'lightsplus:slab_light'},
	}
})
--From Inverted
minetest.register_craft({
	output = '"lightsplus:slab_light"',
	recipe = {
		{'lightsplus:slab_light_inv'},
		}
})
--Wall Slab Light
minetest.register_craft({
	output = '"lightsplus:slab_light_wall" 6',
	recipe = {
		{'lightsplus:light'},
		{'lightsplus:light'},
		{'lightsplus:light'},
	}
})
--Back to a Light
minetest.register_craft({
	output = '"lightsplus:light"',
	recipe = {
		{'lightsplus:slab_light_wall', 'lightsplus:slab_light_wall'},
	}
})
--Inverted Slab Light
minetest.register_craft({
	output = '"lightsplus:slab_light_inv"',
	recipe = {
		{'lightsplus:slab_light'},
		}
})
--Back To a Light
minetest.register_craft({
	output = '"lightsplus:light"',
	recipe = {
		{'lightsplus:slab_light_inv'},
		{'lightsplus:slab_light_inv'},
	}
})
local on_light_puncher = function (pos, node, puncher)
  if node.name == 'lightsplus:light' then
    minetest.env:add_node(pos, {name="lightsplus:light_on"})
    nodeupdate(pos)
  elseif node.name == 'lightsplus:light_on' then
	minetest.env:add_node(pos, {name="lightsplus:light",})
    nodeupdate(pos)
  end
  if node.name == 'lightsplus:slab_light' then
    minetest.env:add_node(pos, {name="lightsplus:slab_light_on"})
    nodeupdate(pos)
  elseif node.name == 'lightsplus:slab_light_on' then
	minetest.env:add_node(pos, {name="lightsplus:slab_light",})
    nodeupdate(pos)
  end
  if node.name == 'lightsplus:slab_light_inv' then
    minetest.env:add_node(pos, {name="lightsplus:slab_light_inv_on"})
    nodeupdate(pos)
  elseif node.name == 'lightsplus:slab_light_inv_on' then
	minetest.env:add_node(pos, {name="lightsplus:slab_light_inv",})
    nodeupdate(pos)
  end
  if node.name == 'lightsplus:slab_light_wall' then
    minetest.env:add_node(pos, {name="lightsplus:slab_light_wall_on", param2=node.param2})
    nodeupdate(pos)
  elseif node.name == 'lightsplus:slab_light_wall_on' then
	minetest.env:add_node(pos, {name="lightsplus:slab_light_wall", param2=node.param2})
    nodeupdate(pos)
  end
end

print("[Lights+] Loaded!")

minetest.register_on_punchnode(on_light_puncher)
