local mod_name = "plants"

local add_plant = function(name_plant, drop) -- register a wild plant
  local name = mod_name..":"..name_plant
  local img = mod_name.."_"..name_plant
  
  if minetest.get_modpath("farming") then
    drops = drop
  else
    drops = ""
  end
  
  minetest.register_node(name.."_wild", {--register wild plant
    tile_images = {img.."_wild.png"},
    inventory_image = img.."_wild.png",
    description = name_plant,
    drop = drops,
    drawtype = "plantlike",
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    visual_scale = 1.3,
    groups = { snappy = 3,flammable=2, floored=1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
      type = "fixed",
      fixed = { -0.25, -0.5, -0.25, 0.25, -3/16, 0.25 },
    },
  })
end

add_plant("cotton",{max_items = 1,items = {{ items = {'farming:cotton_seed'}, rarity = 10}}})
add_plant("corn")
add_plant("lavender")
add_plant("potato")
add_plant("redshroom")
add_plant("cacao")
add_plant("brownshroom")
add_plant("chamomile")
add_plant("colchicum")
add_plant("poppy")
add_plant("grasstall",{max_items = 1,items = {{ items = {'farming:wheat_seed'}, rarity = 40}}})
add_plant("grass",{max_items = 1,items = {{ items = {'farming:wheat_seed'}, rarity = 60}}})

--habitat:generate(node, surface, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes, antitat_size, antitat_nodes)
habitat:generate("plants:lavender_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 4, 4, {"default:sand"},0,{""})
habitat:generate("plants:redshroom_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 20, 8, {"default:leaves"},0,{""})
habitat:generate("plants:corn_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 8, 10, {"default:water_source"},0,{""})
habitat:generate("plants:cotton_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 8, 10, {"default:desert_sand"},0,{""})
habitat:generate("plants:brownshroom_wild", "default:stone", minp, maxp, -40, 2, 2, 10, {"default:water_source"},0,{""})
habitat:generate("plants:chamomile_wild", "default:dirt_with_grass", minp, maxp, 2, 40, 8, 4, {"default:stone_with_coal"},0,{""})
habitat:generate("plants:colchicum_wild", "default:dirt_with_grass", minp, maxp, 2, 40, 4, 4, {"default:stone_with_iron"},0,{""})
habitat:generate("plants:poppy_wild", "default:desert_sand", minp, maxp, 2, 20, 4, 10, {"default:water_source"},0,{""})

habitat:generate("plants:grasstall_wild", "default:dirt_with_grass", minp, maxp, 2, 20, 3, 20, {"default:water_source"},0,{""})
habitat:generate("plants:grass_wild", "default:dirt_with_grass", minp, maxp, 2, 20, 3, 40, {"default:water_source"},0,{""})

print("[Plants] Loaded!")
