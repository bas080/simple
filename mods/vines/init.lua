-- Vines

local VINE_GROW_CHANCE = 10

-- Nodes
minetest.register_node("vines:vine", {
    description = "Vine",
    walkable = false,
    climbable = true,
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_vine.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

minetest.register_node("vines:vine_rotten", {
    description = "Rotten vine",
    walkable = false,
    climbable = false,
    sunlight_propagates = true,
    paramtype = "light",
    tile_images = { "vines_vine_rotten.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine_rotten.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

-- ABMs (growing)
minetest.register_abm({
    nodenames = "vines:vine",
    interval = 2400,
    chance = VINE_GROW_CHANCE,

    action = function(pos, node, _, _)
	
	    minetest.env:remove_node(pos)
	
    end
})

minetest.register_abm({
    nodenames = "vines:vine_rotten",
    interval = 1200,
    chance = VINE_ROT_CHANCE,

    action = function(pos, node, _, _)
	    minetest.env:remove_node(pos)
    end
})

