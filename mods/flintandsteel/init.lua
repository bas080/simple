--Мод "Огниво"
--Для какого-то шапшота 0.4, спасибо автору мода на вёдра.
--Автор:Аскольд

minetest.register_alias("ognivo", "flintandsteel:ognivo")

minetest.register_craft({
	output = 'flintandsteel:ognivo 1',
	recipe = {
		{'default:coal_lump'},
		{'default:steel_ingot'},
	}
})



minetest.register_craftitem("flintandsteel:ognivo", {
	inventory_image = "ognivo.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
				-- Must be pointing to node
				if pointed_thing.type ~= "node" then
					return
				end
				-- Check if pointing to a liquid
				n = minetest.env:get_node(pointed_thing.under)
				if bucket.liquids[n.name] == nil then
					-- Not a liquid
					minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
				elseif n.name ~= source then
					-- It's a liquid
					minetest.env:add_node(pointed_thing.under, {name="fire:basic_flame"})
				end
				return {name="flintandsteel:ognivo"}
			end
})
