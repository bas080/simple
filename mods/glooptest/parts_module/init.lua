glooptest.parts_module = {}
glooptest.debug("MESSAGE","Loading Parts Module Now!")

minetest.register_craftitem("glooptest:chainlink", {
	description = "Chainlink",
	inventory_image = "glooptest_chainlink.png"
})

minetest.register_craft({
	output = "glooptest:chainlink 8",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})