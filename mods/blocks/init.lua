minetest.register_alias("blocks:stone_bricks", "default:stonebrick")

minetest.register_node("blocks:chandelier_hanger", {
  description = "Chandelier",
  tiles = {"blocks_no_texture.png"},
  sunlight_propagates = true,
  groups = {choppy=2,oddly_breakable_by_hand=3, hanging_node=1},
  drawtype = "plantlike",
  walkable = false,
  pointable = false,
  drop = {},
})

minetest.register_node("blocks:chandelier", {
  description = "Chandelier",
  drawtype = "plantlike",
  tiles = {"blocks_chandelier.png"},
  visual_scale = 1.5,
  paramtype = 'light',
  sunlight_propagates = true,
  light_source = 7,
  groups = {choppy=2,oddly_breakable_by_hand=3, hanging_node=1},
  selection_box = {
    type = "fixed",
    fixed = {-2/16, 20/16, -2/16, 2/16, 24/16, 2/16},
  },
  after_place_node = function(pos,node)
    local a = minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z})
    if a.name == "air" then
      minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z}, {name="blocks:chandelier_hanger"})
      minetest.env:set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="blocks:chandelier"})
    else
      drop_attached_node(pos)
    end
  end,
  after_dig_node = function(pos,node)
    minetest.env:remove_node({x=pos.x, y=pos.y+1, z=pos.z})
  end
})

minetest.register_node("blocks:chain_steel", {
  description = "Bronze Steel",
  drawtype = "plantlike",
  tiles = {"blocks_chain_steel.png"},
  visual_scale = 1,
  paramtype = 'light',
  walkable = false;
  sunlight_propagates = true,
  groups = {choppy=2,oddly_breakable_by_hand=3, hanging_node=1},
  selection_box = {
    type = "fixed",
    fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
  },
})

minetest.register_node("blocks:chain_bronze", {
  description = "Bronze Chain",
  drawtype = "plantlike",
  tiles = {"blocks_chain_bronze.png"},
  visual_scale = 1,
  paramtype = 'light',
  walkable = false;
  sunlight_propagates = true,
  groups = {choppy=2,oddly_breakable_by_hand=3, hanging_node=1},
  selection_box = {
    type = "fixed",
    fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
  },
})

minetest.register_node("blocks:chain_gold", {
  description = "Gold Chain",
  drawtype = "plantlike",
  tiles = {"blocks_chain_gold.png"},
  visual_scale = 1,
  paramtype = 'light',
  sunlight_propagates = true,
  groups = {choppy=2,oddly_breakable_by_hand=3, hanging_node=1},
  selection_box = {
    type = "fixed",
    fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
  },
})
