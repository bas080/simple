--[[
****
Map Tools
by Calinou
Licensed under the zlib/libpng license for code and CC BY-SA 3.0 Unported for textures, see LICENSE.txt for info.
****
--]]

--[[

ITEM CODES FOR SPAWNING THE ITEMS USING /GIVE OR /GIVEME:

Items:

- admin_pick
Purple pickaxe, infinite durability, mines everything including unbreakable blocks instantly. Don't put this pickaxe in the hands of a griefer, of course. :)

- infinitefuel
Fuel lasting for a (near)-infinite time. Don't worry about the "near" - it lasts for about 50 in-real-life years.

- superapple
An apple which heals all 10 hearts.

- copper_coin
- silver_coin
- gold_coin
These have nothing to do with the More Ores mod; they can be used as a currency for trading, or as an universal currency for mods that add shops.

Blocks:
A /!\ denotes an unpointable, unbreakable block; be very careful with them, they cannot be removed by hand (they can only be removed with WorldEdit).

- (insert block name here)u ---- example: stone_u
Unbreakable, non-flammable, non-falling, non-decaying blocks, most common blocks have their unbreakable form (examples: maptools:stone or maptools:wood for unbreakable stone/wood).

- fullgrass
Unbrakable block with the "grass" texture on all sides.

- playerclip
/!\ Invisible block, not pointable.

- fullclip
Invisible block, pointable.

- smoke_block
Some smoke.

- nobuild
/!\ Building prevention.

- nointeract
Prevents interacting through the block (interacting as in opening chests, furnaces, attacking entities...).

- damage_(insert damage in half hearts here)
/!\ Damaging blocks. The damage is in half hearts and ranges from 1 to 5 (0.5 to 2.5 hearts damage every second).

- killblock
/!\ Instant kill (deals 10 heart damage) blocks.

- lightblock
/!\ Invisible non-solid block, prevents light from passing through.

- lightbulb
/!\ Invisible non-solid block, emitting a good amount of light.

--]]

-- Aliases

minetest.register_alias("adminpick", "maptools:pick_admin")
minetest.register_alias("adminpickaxe", "maptools:pick_admin")
minetest.register_alias("admin_pick", "maptools:pick_admin")
minetest.register_alias("admin_pickaxe", "maptools:pick_admin")
minetest.register_alias("pick_admin", "maptools:pick_admin")
minetest.register_alias("pickaxe_admin", "maptools:pick_admin")
minetest.register_alias("pickadmin", "maptools:pick_admin")
minetest.register_alias("pickaxeadmin", "maptools:pick_admin")

-- Tools

minetest.register_tool("maptools:pick_admin", {
	description = "Admin Pickaxe",
	inventory_image = "maptools_adminpick.png",
	tool_capabilities = {
		full_punch_interval = 0,
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})
