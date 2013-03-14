glooptest.ore_module = {}
glooptest.debug("MESSAGE","Loading Ore Module Now!")

local stone_sounds = default.node_sound_stone_defaults()

dofile(minetest.get_modpath("glooptest").."/ore_module/api.lua")

-- HUGE NOTE HERE:
-- I did not make the textures. celeron55/erlehmann made the textures which were licensed under CC-BY-SA, and then edited by me.
-- Suck it, minetest community.

glooptest.ore_module.register_ore("glooptest", "kalite", "Kalite", {
	ore = {
		makes = true, 
		drop = "glooptest:kalite_lump", 
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_kalite.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 1/8/8/8,
			chunk_size = 4,
			max_blocks_per_chunk = 10,
			miny = -31000,
			maxy = 10
		},
	},
})

minetest.register_craftitem("glooptest:kalite_lump", {
	description = "Kalite Lump",
	inventory_image = "gloopores_kalite_lump.png",
	on_use = minetest.item_eat(1),
})

minetest.register_node("glooptest:kalite_torch", {
	description = "Kalite Torch",
	drawtype = "torchlike",
	tiles = {
		{name="gloopores_kalite_torch_on_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="gloopores_kalite_torch_on_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="gloopores_kalite_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "gloopores_kalite_torch_on_floor.png",
	wield_image = "gloopores_kalite_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "glooptest:kalite_torch 4",
	recipe = {
		{"glooptest:kalite_lump"},
		{"default:stick"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "gloopores:kalite_lump",
	burntime = 60,
})

glooptest.ore_module.register_ore("glooptest", "alatro", "Alatro", {
	ore = {
		makes = true,
		drop = "glooptest:alatro_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_alatro.png",
		},
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 1/9/9/9,
			chunk_size = 2,
			max_blocks_per_chunk = 6,
			miny = 0,
			maxy = 256
		},
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_alatro_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_alatro_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_alatro_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds
	},
	tools = {
		make = {
			sword = true,
			axe = true,
			pick = true,
			shovel = true
		},
		texture = {
			sword = "gloopores_tool_alatrosword.png",
			axe = "gloopores_tool_alatroaxe.png",
			pick = "gloopores_tool_alatropick.png",
			shovel = "gloopores_tool_alatroshovel.png"
		},
		caps = {
			sword = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps={
					fleshy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
					snappy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
					choppy={times={[3]=0.80}, uses=40, maxlevel=0}
				}
			},
			axe = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					choppy = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1},
					fleshy = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
				}
			},
			pick = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					cracky = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
				}
			},
			shovel = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					crumbly = {times={[2]=0.60, [3]=0.35}, uses=40, maxlevel=1}
				}
			},
		}
	}
})

glooptest.ore_module.register_ore("glooptest", "talinite", "Talinite", {
	ore = {
		makes = true,
		drop = "glooptest:talinite_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_talinite.png"
		},
		groups = {cracky=3},
		sounds = stone_sounds,
		light = 6,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 1/13/13/13,
			chunk_size = 2,
			max_blocks_per_chunk = 4,
			miny = -31000,
			maxy = -250
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_talinite_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_talinite_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_talinite_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds,
		light = 14
	}
})

glooptest.ore_module.register_ore("glooptest", "akalin", "Akalin", {
	ore = {
		makes = true,
		drop = "glooptest:akalin_lump",
		texture = {
			base = "default_desert_stone.png",
			overlay = "gloopores_mineral_akalin.png"
		},
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 1/7/7/7,
			chunk_size = 3,
			max_blocks_per_chunk = 9,
			miny = 0,
			maxy = 256
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_akalin_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_akalin_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_akalin_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds
	}
})

glooptest.ore_module.register_ore("glooptest", "arol", "Arol", {
	ore = {
		makes = true,
		drop = "glooptest:arol_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_arol.png"
		},
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 1/11/11/11,
			chunk_size = 2,
			max_blocks_per_chunk = 2,
			miny = -31000,
			maxy = -20
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_arol_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_arol_ingot.png",
		smeltrecipe = true
	},
	tools = {
		make = {
			sword = true,
			axe = true,
			pick = true,
			shovel = true
		},
		texture = {
			sword = "gloopores_tool_arolsword.png",
			axe = "gloopores_tool_arolaxe.png",
			pick = "gloopores_tool_arolpick.png",
			shovel = "gloopores_tool_arolshovel.png"
		},
		caps = {
			sword = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					fleshy = {times={[2]=1.00, [3]=0.80}, uses=300, maxlevel=1},
					snappy = {times={[2]=1.00, [3]=0.80}, uses=300, maxlevel=1},
					choppy = {times={[3]=1.20}, uses=300, maxlevel=0}
				}
			},
			axe = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					choppy = {times={[1]=3.00, [2]=1.00, [3]=0.70}, uses=300, maxlevel=1},
					fleshy = {times={[2]=1.30, [3]=0.70}, uses=300, maxlevel=1}
				}
			},
			pick = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					cracky = {times={[1]=3.00, [2]=1.20, [3]=0.80}, uses=300, maxlevel=1}
				}
			},
			shovel = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					crumbly = {times={[1]=1.50, [2]=0.75, [3]=0.45}, uses=300, maxlevel=1}
				}
			}
		}
	}
})

glooptest.ore_module.register_ore("glooptest", "desert_iron", "Desert Iron", {
	ore = {
		makes = true, 
		drop = "default:iron_lump", 
		texture = {
			base = "default_desert_stone.png",
			overlay = "default_mineral_iron.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 1/7/7/7,
			chunk_size = 2,
			max_blocks_per_chunk = 3,
			miny = 0,
			maxy = 10
		},
	},
})

glooptest.ore_module.register_ore("glooptest", "desert_coal", "Desert Coal", {
	ore = {
		makes = true, 
		drop = "default:coal_lump", 
		texture = {
			base = "default_desert_stone.png",
			overlay = "default_mineral_coal.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 1/6/6/6,
			chunk_size = 3,
			max_blocks_per_chunk = 8,
			miny = 0,
			maxy = 30
		},
	},
})