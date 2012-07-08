-- Unified Dyes Mod by Vanessa Ezekowitz  ~~  2012-06-26
--
-- License: GPL
--
-- This mod requires ironzorg's flowers mod, which should have
-- been included in the distribution archive in which this mod
-- was found.
--

-- White paint

minetest.register_craftitem("unifieddyes:titanium_dioxide", {
        description = "Titanium Dioxide Powder",
        inventory_image = "unifieddyes_titanium_dioxide.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:titanium_dioxide 10",
        recipe = "default:stone",
})

minetest.register_craftitem("unifieddyes:white_paint", {
        description = "White Paint",
        inventory_image = "unifieddyes_white_paint.png",
})

minetest.register_craft( {
        type = 'shapeless',
        output = 'unifieddyes:white_paint',
        recipe = {
                'unifieddyes:titanium_dioxide',
                'bucket:bucket_water',
                'default:junglegrass',
        },
})

-- Green (cactus)

minetest.register_craftitem("unifieddyes:green", {
        description = "Green Dye",
        inventory_image = "unifieddyes_green.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:green 2",
        recipe = "default:cactus",
})

-- Black (coal)

minetest.register_craftitem("unifieddyes:black", {
	description = "Black Dye",
	inventory_image = "unifieddyes_black.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:black 2",
        recipe = "default:coal_lump",
})

--	Red (rose)

minetest.register_craftitem("unifieddyes:red", {
	description = "Red Dye",
	inventory_image = "unifieddyes_red.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:red 2",
        recipe = "flowers:flower_rose",
})

--	Orange (tulip)

minetest.register_craftitem("unifieddyes:orange", {
	description = "Orange Dye",
	inventory_image = "unifieddyes_orange.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:orange 2",
        recipe = "flowers:flower_tulip",
})

-- 	Yellow (yellow dandelion)

minetest.register_craftitem("unifieddyes:yellow", {
	description = "Yellow Dye",
	inventory_image = "unifieddyes_yellow.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:yellow 2",
        recipe = "flowers:flower_dandelion_yellow",
})

--	Blue (Viola)

minetest.register_craftitem("unifieddyes:blue", {
	description = "Blue Dye",
	inventory_image = "unifieddyes_blue.png",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:blue 2",
        recipe = "flowers:flower_viola",
})

-- Violet (craft Blue and Red dyes together)

minetest.register_craftitem("unifieddyes:violet", {
	description = "Violet Dye",
	inventory_image = "unifieddyes_violet.png",
})

minetest.register_craft( {
	type = 'shapeless',
        output = 'unifieddyes:violet 2',
        recipe = {
		'unifieddyes:blue',
		'unifieddyes:red',
        },
})

-- Alternate crafts for other non-primary colors

minetest.register_craft( {
        type = 'shapeless',
        output = 'unifieddyes:orange 2',
        recipe = {
                'unifieddyes:red',
                'unifieddyes:yellow'
        },
})

minetest.register_craft( {
        type = 'shapeless',
        output = 'unifieddyes:green 2',
        recipe = {
                'unifieddyes:yellow',
                'unifieddyes:blue'
        },
})

print("[UnifiedDyes] Loaded!")

