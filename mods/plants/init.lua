--Harvest
--A simple farming mod
--A extended plant spawning mod

--register alias to avoid unknown plants from previous harvest version

--Variable and function definitions
local mod_name = "plants"

local wild_crops = {}
local wild_crop_count = 0

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

--plant registration
--Just wild plant
--node registration
minetest.register_alias("harvest:lavender_wild", "plants:lavender_wild")
minetest.register_alias("harvest:redshroom_wild", "plants:redshroom_wild")
minetest.register_alias("harvest:corn_wild", "plants:corn_wild")
minetest.register_alias("harvest:cotton_wild", "plants:cotton_wild")
minetest.register_alias("harvest:brownshroom_wild", "plants:brownshroom_wild")
minetest.register_alias("harvest:chamomile_wild", "plants:chamomile_wild")
minetest.register_alias("harvest:colchicum_wild", "plants:colchicum_wild")
minetest.register_alias("harvest:poppy_wild", "plants:poppy_wild")
minetest.register_alias("harvest:grasstall_wild", "plants:grasstall_wild")
minetest.register_alias("harvest:grass_wild", "plants:grass_wild")
--Make node in which dirt changes after hoe preperation

--create plant nodes. Not all plants spawn in the wild for this you have to define it on the generate on function
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

--generate(node, surface, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes)
--For the plants that do spawn on the lang we have the generate function. This makes sure that plants are placed when new peaces of the level are loaded.
minetest.register_on_generated(function(minp, maxp, seed)
	generate("plants:lavender_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 4, 4, {"default:sand"},0,{""})
	generate("plants:redshroom_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 20, 8, {"default:leaves"},0,{""})
	generate("plants:corn_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 8, 10, {"default:water_source"},0,{""})
	generate("plants:cotton_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 8, 10, {"default:desert_sand"},0,{""})
	generate("plants:brownshroom_wild", {"default:stone"}, minp, maxp, -40, -10, 2, 10, {"default:water_source"},0,{""})
	generate("plants:chamomile_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 40, 8, 4, {"default:stone_with_coal"},0,{""})
	generate("plants:colchicum_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 40, 4, 10, {"default:stone_with_iron"},0,{""})
	generate("plants:poppy_wild", {"defaultw:desert_sand"}, minp, maxp, -10, 20, 4, 10, {"default:water_source"},0,{""})
	generate("plants:grasstall_wild", {"default:dirt_with_grass"}, minp, maxp, 2, 20, 3, 3, {"default:water_source"},0,{""})
	generate("plants:grass_wild", {"default:dirt_with_grass"}, minp, maxp, 2, 20, 3, 3, {"default:water_source"},0,{""})
end)

print("[Harvest] Loaded!")
