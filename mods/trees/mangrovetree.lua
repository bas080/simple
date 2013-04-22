--function
local function add_leaves(pos, leave)
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			for n = math.floor(math.random(1)), 0, -1 do
				local p = {x=pos.x+i, y=pos.y+n, z=pos.z+k}
				local n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name=leave})
				end
			end
		end
	end
end
abstract_trees.grow_mangrovetree = function(pos)
  local size = 6+math.random(6)
  local trunk_node
  local leaves_node
  if math.ceil(math.random(2)) == 1 then
    trunk_node = "trees:tree_dead_mangrove"
    leaves_node = "trees:leaves_dead_mangrove"
  else
    trunk_node = "trees:tree_mangrove"
    leaves_node = "trees:leaves_mangrove"
  end
  local top = {x=pos.x, y=pos.y+size, z=pos.z}
  if math.ceil(math.random(2)) == 1 then
    minetest.env:add_node({x=top.x+1, y=top.y, z=top.z}, {name=trunk_node})
    add_leaves({x=top.x+1, y=top.y, z=top.z},leaves_node)
    minetest.env:add_node({x=top.x-1, y=top.y, z=top.z}, {name=trunk_node})
    add_leaves({x=top.x-1, y=top.y, z=top.z},leaves_node)
  else
    minetest.env:add_node({x=top.x, y=top.y, z=top.z-1}, {name=trunk_node})
    add_leaves({x=top.x, y=top.y, z=top.z-1},leaves_node)
    minetest.env:add_node({x=top.x, y=top.y, z=top.z+1}, {name=trunk_node})
    add_leaves({x=top.x, y=top.y, z=top.z+1},leaves_node)
  end
  for i=1, size, 1 do
    if math.ceil(math.random(2)) == 1 then
      local dir = {
        x=math.ceil(math.random(3))-2,
        y=math.ceil(math.random(3))-2,
        z=math.ceil(math.random(3))-2,
      }
      if i > size/2 then
        minetest.env:add_node({x=pos.x+dir.x, y=top.y-i, z=pos.z+dir.z}, {name=leaves_node})
      else
        minetest.env:add_node({x=pos.x+dir.x*2, y=top.y-i, z=pos.z+dir.z*2}, {name=leaves_node})
        minetest.env:add_node({x=pos.x+dir.x, y=top.y-i, z=pos.z+dir.z}, {name=trunk_node})
      end
    end
    minetest.env:add_node({x=top.x, y=top.y-i, z=top.z}, {name=trunk_node})
  end
  minetest.env:add_node({x=pos.x-1, y=pos.y, z=pos.z}, {name=trunk_node})
  minetest.env:add_node({x=pos.x+1, y=pos.y, z=pos.z}, {name=trunk_node})
  minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z+1}, {name=trunk_node})
  minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z-1}, {name=trunk_node})
end
--nodes
name = "dead_mangrove"
minetest.register_node("trees:leaves_"..name, {
  description = name.. " Leaves",
  drawtype = "allfaces_optional",
  tiles = {"trees_leaves_"..name..".png"},
  paramtype = "light",
  groups = {snappy=3, leafdecay=3, flammable=2},
  sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("trees:tree_"..name, {
  description = name.. " Tree",
  tiles = {"trees_tree_top_"..name..".png", "trees_tree_top_"..name..".png", "trees_tree_"..name..".png"},
  groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
  sounds = default.node_sound_wood_defaults(),
})
name = "mangrove"
minetest.register_node("trees:leaves_"..name, {
  description = name.. " Leaves",
  drawtype = "allfaces_optional",
  tiles = {"trees_leaves_"..name..".png"},
  paramtype = "light",
  groups = {snappy=3, leafdecay=3, flammable=2},
  drop = {
	  max_items = 1,
	  items = {
		  {items = {'jungletree:sapling'},rarity = 20},
	  }
  },
  sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("trees:tree_"..name, {
  description = name.. " Tree",
  tiles = {"trees_tree_top_"..name..".png", "trees_tree_top_"..name..".png", "trees_tree_"..name..".png"},
  groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
  sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("trees:wood_"..name, {
  description = name.. " Wood",
  tiles = {"trees_wood_"..name..".png"},
  groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
  sounds = default.node_sound_wood_defaults(),
})

--spawning
plantslib:register_generate_plant({
    surface = "default:dirt",
    max_count = 30,
    near_nodes = {"default:water_source"},
    near_nodes_size = 1,
    near_nodes_vertical = 3,
    near_nodes_count = 6,
    avoid_nodes = {"group:tree", "default:sand"},
    avoid_radius = 3,
    rarity = 50,
    seed_diff = 666,
    min_elevation = -3,
    max_elevation = 2,
    plantlife_limit = -0.5,
    check_air = false,
    humidity_max = -1,
    humidity_min = 0.5,
    temp_max = -0.8,
    temp_min = 0,
  },
  "abstract_trees.grow_mangrovetree"
)

--abstract_trees.grow_mangrovetree(pointed_thing.above, height)
