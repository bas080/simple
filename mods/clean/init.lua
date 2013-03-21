local old_nodes = {"berrybush:berrybush","poisonivy:sproutling","poisonivy:climbing"}
local old_entities = {}

for _,node_name in ipairs(old_nodes) do
	minetest.register_node(":"..node_name, {
		groups = {old=1},
	})
end

minetest.register_abm({
	nodenames = {"group:old"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.env:remove_node(pos)
	end,
})

for _,entity_name in ipairs(old_entities) do
	minetest.register_entity(":"..entity_name, {
		on_activate = function(self, staticdata)
			self.object:remove()
		end,
	})
end
