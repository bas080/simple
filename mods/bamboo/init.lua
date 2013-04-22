local mod_name = "bamboo"
local average_height = 4

minetest.register_craft({
	output = 'bamboo:block',
	recipe = {
		{'bamboo:item', 'bamboo:item', ''},
		{'bamboo:item', 'bamboo:item', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'bamboo:block_dry',
	recipe = {
		{'bamboo:item_dry', 'bamboo:item_dry', ''},
		{'bamboo:item_dry', 'bamboo:item_dry', ''},
		{'', '', ''},
	}
})

minetest.register_craftitem("bamboo:item", {
	description = "Bamboo Damp",
	inventory_image = "bamboo_item.png",
})

minetest.register_craftitem("bamboo:item_dry", {
	description = "Bamboo Dry",
	inventory_image = "bamboo_item_dry.png",
})

minetest.register_node("bamboo:bamboo_top", {
  tile_images = {"bamboo_top.png"},
  inventory_image = "bamboo_top.png",
  description = "bamboo",
  drawtype = "plantlike",
  sunlight_propagates = true,
  visual_scale = 1.7,
  paramtype = "light",
  walkable = false,
  groups = { snappy = 3,flammable=2, attached_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 },
  },
  drop = {
  max_items = 2,
  items = {
    {
      items = {'bamboo:sapling'},
      rarity = 2,
      },
      {
      items = {"bamboo:item"},
      }
    }
  },
  on_construct = function(pos, placer)
    local p = {x=pos.x, y=pos.y, z=pos.z}
    local n = minetest.env:get_node(p)
    local down=1
    
    local height=2+math.random(0,average_height)
    
    minetest.env:set_node(p, {name="bamboo:bamboo"})
    
    while down < height do
      local pt = {x = p.x, y= p.y+down, z=p.z}
      local nt = minetest.env:get_node(pt)
      if nt.name == "air" then
        minetest.env:add_node(pt, {name="bamboo:bamboo"})
        down=down+1
      else
        return
      end
    end
  end,
})

minetest.register_node("bamboo:bamboo", {
  tile_images = {"bamboo.png"},
  inventory_image = "bamboo.png",
  description = "Bamboo",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      {-5/16, -0.5, -5/16, -2/16, 0.5, -2/16},
      {5/16, -0.5, 5/16, 2/16, 0.5, 2/16},
      {-5/16, 0.5, 5/16, -2/16, -0.5, 2/16},
      {5/16, 0.5, -5/16, 2/16, -0.5, -2/16}
    },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.33, -0.5, -0.33, 0.33, 0.5, 0.33 },
  },
  sunlight_propagates = true,
  paramtype = "light",
  walkable = true,
  groups = {tree=1, snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1, attached_node=1},
  sounds = default.node_sound_wood_defaults(),
  drop = {
  max_items = 2,
  items = {
    {
      items = {'bamboo:sapling'},
      rarity = 3,
      },
      {
      items = {"bamboo:item"},
      }
    }
  },
})

minetest.register_node("bamboo:bamboo_dry", {
  tile_images = {"bamboo_dry.png"},
  inventory_image = "bamboo_dry.png",
  description = "Bamboo",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      {-5/16, -0.5, -5/16, -2/16, 0.5, -2/16},
      {5/16, -0.5, 5/16, 2/16, 0.5, 2/16},
      {-5/16, 0.5, 5/16, -2/16, -0.5, 2/16},
      {5/16, 0.5, -5/16, 2/16, -0.5, -2/16}
    },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.33, -0.5, -0.33, 0.33, 0.5, 0.33 },
  },
  sunlight_propagates = true,
  paramtype = "light",
  walkable = true,
  groups = {tree=1, snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1, attached_node=1},
  sounds = default.node_sound_wood_defaults(),
  drop = {
  max_items = 2,
  items = {
    {
      items = {'bamboo:sapling'},
      rarity = 6,
      },
      {
      items = {"bamboo:item_dry"},
      }
    }
  },
})

minetest.register_node("bamboo:sapling", {
  tile_images = {"bamboo_top.png"},
  inventory_image = "bamboo_top.png",
  description = "Bamboo Cutting",
  drawtype = "plantlike",
  sunlight_propagates = true,
  visual_scale = 0.9,
  paramtype = "light",
  walkable = false,
  groups = { snappy = 3,flammable=2, attached_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 },
  },
  
})

minetest.register_abm({
  nodenames = {"bamboo:bamboo_top"},
  interval = 30,
  chance = 5,
  action = function(pos)
  
    minetest.env:add_node(pos, {name="bamboo:bamboo"})
    if math.random(0, (average_height)) > 1.0 then
      local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
      local n_top = minetest.env:get_node(p_top)
      if n_top.name =="air" then
        minetest.env:add_node(p_top, {name="bamboo:bamboo_top"})
      end
    end
  end,
})

minetest.register_abm({
  nodenames = {"bamboo:bamboo"},
  interval = 300,
  chance = 2,
  action = function(pos)
    minetest.env:add_node(pos, {name="bamboo:bamboo_dry"})
  end,
})

minetest.register_abm({
  nodenames = {"bamboo:sapling"},
  interval = 30,
  chance = 10,
  action = function(pos)
    minetest.env:add_node(pos, {name="bamboo:bamboo"})
    local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
    local n_top = minetest.env:get_node(p_top)
    if n_top.name =="air" then
      minetest.env:add_node(p_top, {name="bamboo:bamboo_top"})
    end
    
  end,
})

minetest.register_node("bamboo:block", {
	description = "Damp Bamboo Block",
	tiles = {"bamboo_node.png"},
	is_ground_content = true,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bamboo:block_dry", {
	description = "Dry Bamboo Block",
	tiles = {"bamboo_node_dry.png"},
	is_ground_content = true,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

--spawn
plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    max_count = 20,
    avoid_nodes = {"group:tree"},
    avoid_radius = 2,
    rarity = 40,
    seed_diff = 456,
    min_elevation = 10,
    max_elevation = 80,
    plantlife_limit = -0.4,
    humidity_max = -0.4,
    humidity_min = 0.4,
    temp_max = -0.6,
    temp_min = 0.2,
  },
  "bamboo:bamboo_top"
)

print("[Bamboo] Loaded!")
