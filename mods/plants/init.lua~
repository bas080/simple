local mod_name = "plants"

local add_plant = function(name_plant) -- register a wild plant
  local name = mod_name..":"..name_plant
  local img = mod_name.."_"..name_plant
  
  minetest.register_node(name.."_wild", {--register wild plant
    tile_images = {img.."_wild.png"},
    inventory_image = img.."_wild.png",
    description = name_plant,
    drawtype = "plantlike",
    sunlight_propagates = true,
    paramtype = "light",
    walkable = false,
    groups = { snappy = 3,flammable=2, floored=1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
      type = "fixed",
      fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 },
    },
  })
end

add_plant("cotton")
add_plant("corn")
add_plant("lavender")
add_plant("potato")
add_plant("redshroom")
add_plant("cacao")
add_plant("brownshroom")
add_plant("chamomile")
add_plant("colchicum")
add_plant("poppy")
add_plant("grasstall")
add_plant("grass")

habitat:generate("plants:lavender_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 4, 4, {"default:sand"},0,{""})
habitat:generate("plants:redshroom_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 20, 8, {"default:leaves"},0,{""})
habitat:generate("plants:corn_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 8, 10, {"default:water_source"},0,{""})
habitat:generate("plants:cotton_wild", "default:dirt_with_grass", minp, maxp, 2, 60, 8, 10, {"default:desert_sand"},0,{""})
habitat:generate("plants:brownshroom_wild", "default:stone", minp, maxp, -40, 2, 2, 10, {"default:water_source"},0,{""})
habitat:generate("plants:chamomile_wild", "default:dirt_with_grass", minp, maxp, 2, 40, 8, 4, {"default:stone_with_coal"},0,{""})
habitat:generate("plants:colchicum_wild", "default:dirt_with_grass", minp, maxp, 2, 40, 4, 4, {"default:stone_with_iron"},0,{""})
habitat:generate("plants:poppy_wild", "defaultw:desert_sand", minp, maxp, 2, 20, 4, 10, {"default:water_source"},0,{""})
habitat:generate("plants:grasstall_wild", "default:dirt_with_grass", minp, maxp, 2, 20, 3, 3, {"default:water_source"},0,{""})
habitat:generate("plants:grass_wild", "default:dirt_with_grass", minp, maxp, 2, 20, 3, 3, {"default:water_source"},0,{""})

print("[Plants] Loaded!")
