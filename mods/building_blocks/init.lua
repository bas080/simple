minetest.register_alias("tar", "building_blocks:Tar")
minetest.register_alias("tar_knife", "building_blocks:knife")
minetest.register_alias("adobe", "building_blocks:Adobe")
minetest.register_alias("building_blocks_roofing", "building_blocks:Roofing")
minetest.register_alias("hardwood", "building_blocks:hardwood")
minetest.register_alias("faggot", "building_blocks:faggot")
minetest.register_alias("marble", "building_blocks:Marble")

minetest.register_node("building_blocks:Adobe", {
	tiles = {"building_blocks_Adobe.png"},
	description = "Adobe",
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Roofing", {
	tiles = {"building_blocks_Roofing.png"},
	is_ground_content = true,
	description = "Roof block",
	groups = {snappy=3},
})
minetest.register_craft({
	output = 'building_blocks:terrycloth_towel 2',
	recipe = {
		{"flowers:cotton", "flowers:cotton", "flowers:cotton"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Tarmac_spread 4',
	recipe = {
		{"building_blocks:Tar", "building_blocks:Tar"},
	}
})
minetest.register_craft({
	output = 'building_blocks:gravel_spread 4',
	recipe = {
		{"default:gravel", "default:gravel", "default:gravel"},
	}
})
minetest.register_craft({
	output = 'building_blocks:brobble_spread 4',
	recipe = {
		{"default:brick", "default:cobble", "default:brick"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Fireplace 1',
	recipe = {
		{"default:steel_ingot", "building_blocks:faggot", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Adobe 3',
	recipe = {
		{"default:sand"},
		{"default:clay"},
		{"default:stick"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Roofing 10',
	recipe = {
		{"building_blocks:Adobe", "building_blocks:Adobe"},
		{"building_blocks:Adobe", "building_blocks:Adobe"},
	}
})
minetest.register_craft({
	output = 'building_blocks:grate 1',
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:glass", "default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:woodglass 1',
	recipe = {
		{"default:wood"},
		{"default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:hardwood 1',
	recipe = {
		{"default:wood", "default:wood"},
		{"default:wood", "default:wood"},
	}
})
minetest.register_craft({
	output = 'building_blocks:faggot 1',
	recipe = {
		{'craft "default:stick"', 'craft "default:stick"'},
		{'craft "default:stick"', 'craft "default:stick"'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "building_blocks:smoothglass",
	recipe = "default:glass"
})
minetest.register_node("building_blocks:smoothglass", {
	drawtype = "glasslike",
	description = "Streak Free Glass",
	tiles = {"building_blocks_sglass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:grate", {
	drawtype = "glasslike",
	description = "Grate",
	tiles = {"building_blocks_grate.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1},
})
minetest.register_node("building_blocks:Fireplace", {
	drawtype = "stonelike",
	description = "fireplace",
	tiles = {"building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron_fireplace.png"},
	paramtype = "facedir_simple",
	light_source = LIGHT_MAX,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
})
minetest.register_node("building_blocks:woodglass", {
	drawtype = "glasslike",
	description = "Wood Framed Glass",
	tiles = {"building_blocks_wglass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:terrycloth_towel", {
	drawtype = "raillike",
	description = "Terrycloth towel",
	tiles = {"building_blocks_towel.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:Tarmac_spread", {
	drawtype = "raillike",
	description = "Tarmac Spread",
	tiles = {"tar.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("building_blocks:brobble_spread", {
	drawtype = "raillike",
	description = "Brobble Spread",
	tiles = {"building_blocks_brobble.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:gravel_spread", {
	drawtype = "raillike",
	description = "Gravel Spread",
	tiles = {"default_gravel.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
})
minetest.register_node("building_blocks:hardwood", {
	tiles = {"building_blocks_hardwood.png"},
	is_ground_content = true,
	description = "Hardwood",
	groups = {choppy=1,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

stairs = {}

-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("building_blocks:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	})

	minetest.register_craft({
		output = 'building_blocks:stair_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'building_blocks:stair_' .. subname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("building_blocks:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	})

	minetest.register_craft({
		output = 'building_blocks:slab_' .. subname .. ' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab)
end
stairs.register_stair_and_slab("marble","building_blocks:Marble",
	{cracky=3},
	{"marble.png"},
	"Marble stair",
	"Marble slab")
stairs.register_stair_and_slab("hardwood","building_blocks:hardwood",
		{snappy=1,choppy=1,flammable=1},
		{"building_blocks_hardwood.png"},
		"Hardwood stair",
		"Hardwood slab")
stairs.register_stair_and_slab("tar","building_blocks:Tar",
		{crumbly=1},
		{"tar.png"},
		"Tar stair",
		"Tar slab")
stairs.register_stair_and_slab("grate","building_blocks:grate",
		{crumbly=1},
		{"building_blocks_grate.png"},
		"Grate Stair",
		"Grate Slab")
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:hardwood",
	burntime = 28,
})

minetest.register_craftitem("building_blocks:faggot", {
	image = "building_blocks_faggot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--Tar
minetest.register_craft({
	output = 'building_blocks:knife 1',
	recipe = {
		{"building_blocks:Tar"},
		{"Stick"},
	}
})

minetest.register_node("building_blocks:Tar", {
	description = "Tar",
	tiles = {"tar.png"},
	is_ground_content = true,
	groups = {crumbly=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Marble", {
	description = "Marble",
	tiles = {"marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:faggot",
	burntime = 5,
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:Tar",
	burntime = 40,
})
minetest.register_craft({
	type = "cooking",
	output = "building_blocks:Tar",
	recipe = "default:gravel",
})

minetest.add_to_creative_inventory('building_blocks:Tar 0')
minetest.add_to_creative_inventory('building_blocks:hardwood 0')
minetest.register_craft({
	output = "building_blocks:Marble 9",
	recipe = {
		{"default:clay", "building_blocks:Tar", "default:clay"},
		{"building_blocks:Tar","default:clay", "building_blocks:Tar"},
		{"default:clay", "building_blocks:Tar","default:clay"},
	}
})

