-- REMOVE_STONE

minetest.register_node("mesecons_random:removestone", {
	tile_images = {"jeija_removestone.png"},
	inventory_image = minetest.inventorycube("jeija_removestone_inv.png"),
	material = minetest.digprop_stonelike(1.0),
	groups = {cracky=3, mesecon = 2},
	description="Removestone",
})

mesecon:register_effector(nil, "mesecons_random:removestone")

minetest.register_craft({
	output = '"mesecons_random:removestone" 4',
	recipe = {
		{'', '"default:cobble"',''},
		{'"default:cobble"', '"group:mesecon_conductor_craftable"', '"default:cobble"'},
		{'', '"default:cobble"',''},
	}
})

mesecon:register_on_signal_on(function(pos, node)
	if node.name=="mesecons_random:removestone" then
		minetest.env:remove_node(pos)
	end
end)
