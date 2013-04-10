minetest.register_node("blocks:stone_bricks", {
  description = "Stone bricks",
  tiles = {"blocks_stone_bricks.png"},
  is_ground_content = true,
  groups = {cracky=3, stone=1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
  output = "blocks:stone_bricks 4",
  recipe = {
    {'','default:stone','default:stone'},
    {'default:stone','default:stone',''},
  }
})

minetest.register_node("blocks:chandelier", {
  description = "Chandelier",
  drawtype = "plantlike",
  tiles = {"blocks_chandelier.png"},
  visual_scale = 1.5,
  paramtype = 'light',
  sunlight_propagates = true,
  light_source = 7,
  groups = {choppy=2,oddly_breakable_by_hand=3},
  selection_box = {
    type = "fixed",
    fixed = {-4/16, 20/16, -4/16, 4/16, 24/16, 4/16},
  },
  after_place_node = function(pos,node)
    local a = minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z})
    if a.name == "air" then
      minetest.env:remove_node(pos)
      minetest.env:add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="blocks:chandelier"})
    else
      drop_attached_node(pos)
    end
  end,
})
