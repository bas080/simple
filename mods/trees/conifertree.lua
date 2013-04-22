abstract_trees.grow_conifertree = function(pos)
  local size = 5+math.random(10)
  local slope = size/3
  local rad = 1
  minetest.env:add_node({x=pos.x, y=pos.y+size, z=pos.z}, {name="trees:leaves_conifer"})
  for i=1,size,1 do
    local spawn = {x=pos.x, y=pos.y+size-i, z=pos.z}
    
    if i < size * 0.75 then
      for k=-rad,rad,1 do
        for n=-rad,rad,1 do
          minetest.env:add_node({x=pos.x+k, y=pos.y+size-i, z=pos.z+n}, {name="trees:leaves_conifer"})
        end
      end
      if i > slope*rad then
        i = i - 1
        minetest.env:add_node({x=pos.x+rad, y=pos.y+size-i, z=pos.z+rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x+rad, y=pos.y+size-i, z=pos.z-rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x-rad, y=pos.y+size-i, z=pos.z+rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x-rad, y=pos.y+size-i, z=pos.z-rad}, {name="trees:leaves_conifer"})
        i = i + 1
        rad = rad + 1
        minetest.env:add_node({x=pos.x+rad, y=pos.y+size-i, z=pos.z+rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x+rad, y=pos.y+size-i, z=pos.z-rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x-rad, y=pos.y+size-i, z=pos.z+rad}, {name="trees:leaves_conifer"})
        minetest.env:add_node({x=pos.x-rad, y=pos.y+size-i, z=pos.z-rad}, {name="trees:leaves_conifer"})
      end
    end
    minetest.env:add_node(spawn, {name="trees:tree_conifer"})
  end
end
--nodes
minetest.register_node("trees:tree_conifer", {
	description = "Conifer trunk",
	tile_images = { 
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png" 
	},
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("trees:leaves_conifer", {
	description = "Conifer leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = { "conifers_leaves.png" },
	--inventory_image = "conifers_leaves.png",
	paramtype = "light",
	groups = {
		snappy = 3,
		leafdecay = 3,
		flammable = 2
	},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'trees:sapling_conifer'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("trees:sapling_conifer", {
	description = "Conifer sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tile_images = {"conifers_sapling.png"},
	inventory_image = "conifers_sapling.png",
	wield_image = "conifers_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {
		snappy = 2,
		dig_immediate = 3,
		flammable = 2
	},
	sounds = default.node_sound_defaults(),
})
-- abm
minetest.register_abm({
  nodenames = "trees:sapling_conifer",
  interval = 1000,
  chance = 4,
  action = function(pos, node, _, _)
    if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
      abstract_trees.grow_conifertree({x = pos.x, y = pos.y, z = pos.z})
      end
    end
})

--spawn
plantslib:register_generate_plant({
    surface = {"default:dirt", "default:dirt_with_grass", "snow:dirt_with_snow", "snow:snow"},
    max_count = 30,
    avoid_nodes = {"group:tree"},
    avoid_radius = 2,
    rarity = 50,
    seed_diff = 777,
    min_elevation = -1,
    max_elevation = 100,
    plantlife_limit = -0.6,
    humidity_max = -1,
    humidity_min = 0.2,
    temp_max = 0,
    temp_min = -0.8,
  },
  "abstract_trees.grow_conifertree"
)
