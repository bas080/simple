
-- override default gravel to drop flint
local gravel = {}
for k,v in pairs(minetest.registered_nodes["default:gravel"]) do
	gravel[k] = v
end
gravel.drop = {
	max_items = 1,
	items = {
		{items = {'flint_and_steel:flint'}, rarity = 5},
		{items = {'default:gravel'}},
	}
}
minetest.register_node(":default:gravel", gravel)

-- register flint_and_steel
minetest.register_craftitem("flint_and_steel:flint_and_steel", {
	inventory_image = "flint_and_steel.png",
	stack_max = 1,
	liquids_pointable = false,
	on_use = function(itemstack, user, pointed_thing)
		n = minetest.env:get_node(pointed_thing)
		if pointed_thing.type == "node" then
			minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
		end
		itemstack:add_wear(65535/50)
	end,
})

-- register flint
minetest.register_craftitem("flint_and_steel:flint", {
	inventory_image = "flint.png",
	stack_max = 99,
	liquids_pointable = false,
})

-- craft
minetest.register_craft({
	type = 'shapeless',
    output = 'flint_and_steel:flint_and_steel',
    recipe = {'default:steel_ingot', 'flint_and_steel:flint'},
})