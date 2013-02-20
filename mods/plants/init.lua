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


plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:sand"},
    near_nodes_size = 4,
    near_nodes_vertical = 3,
    min_elevation = 2,
    max_elevation = 60,
    rarity = 8,
    plantlife_limit = -0.9,
    max_count = 30,
  }, 
  "plants:lavender_wild"
)


plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:leaves"},
    near_nodes_size = 8,
    near_nodes_vertical = 1,
    min_elevation = 2,
    max_elevation = 60,
    rarity = 10,
    plantlife_limit = -0.8,
    max_count = 15,
  }, 
  "plants:redshroom_wild"
)


plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:water_source"},
    near_nodes_size = 5,
    near_nodes_vertical = 5,
    min_elevation = 2,
    max_elevation = 60,
    rarity = 2,
    plantlife_limit = -1,
    max_count = 5,
  }, 
  "plants:corn_wild"
)

plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:desert_sand"},
    near_nodes_size = 5,
    near_nodes_vertical = 1,
    min_elevation = 2,
    max_elevation = 60,
    rarity = 8,
    plantlife_limit = -0.5,
    max_count = 3,
  }, 
  "plants:cotton_wild"
)

plantslib:register_generate_plant({
    surface = "default:stone",
    near_nodes = {"default:water_source"},
    near_nodes_size = 5,
    near_nodes_vertical = 2,
    min_elevation = -40,
    max_elevation = 2,
    rarity = 2,
    plantlife_limit = -0.7,
    max_count = 10,
  }, 
  "plants:brownshroom_wild"
)



plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:stone_with_coal"},
    near_nodes_size = 4,
    near_nodes_vertical = 4,
    min_elevation = 2,
    max_elevation = 40,
    rarity = 8,
    max_count = 10,
  }, 
  "plants:chamomile_wild"
)

plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:stone_with_iron"},
    near_nodes_size = 4,
    near_nodes_vertical = 4,
    min_elevation = 2,
    max_elevation = 40,
    rarity = 4,
  }, 
  "plants:colchicum_wild"
)

plantslib:register_generate_plant({
    surface = "default:desert_sand",
    near_nodes = {"default:water_source"},
    near_nodes_size = 4,
    near_nodes_vertical = 10,
    min_elevation = 2,
    max_elevation = 40,
    rarity = 8,
  }, 
  "plants:poppy_wild"
)

plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:water_source"},
    near_nodes_size = 8,
    near_nodes_vertical = 2,
    near_nodes_count = 2,
    min_elevation = 2,
    max_elevation = 40,
    rarity = 4,
    plantlife_limit = -1,
    max_count = 40
  }, 
  "plants:grasstall_wild"
)

plantslib:register_generate_plant({
    surface = "default:dirt_with_grass",
    near_nodes = {"default:water_source"},
    near_nodes_size = 16,
    near_nodes_vertical = 4,
    near_nodes_count = 2,
    min_elevation = 2,
    max_elevation = 60,
    rarity = 4,
    plantlife_limit = -1,
    max_count = 20
  }, 
  "plants:grass_wild"
)

print("[Plants] Loaded!")
