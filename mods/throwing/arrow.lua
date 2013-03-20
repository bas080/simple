minetest.register_craftitem("throwing:arrow", {
	description = "Arrow",
	inventory_image = "throwing_arrow.png",
})

minetest.register_node("throwing:arrow_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6/16, -1/16, -1/16, 7/16, 1/16, 1/16},
			--Spitze
			{-7/16, -1/16, -1/16, -6/16, 1/16, 1/16},
			--Federn
			{7/16, 0/16, 1/16, 8/16, 0/16, 2/16},
			{7/16, 0/16, -1/16, 8/16, 0/16, -2/16},
			{7/16, 1/16, 0/16, 8/16, 2/16, 0/16},
			{7/16, -1/16, 0/16, 8/16, -2/16, 0/16},
		}
	},
	tiles = {"throwing_arrow.png", "throwing_arrow.png", "throwing_arrow_back.png", "throwing_arrow_front.png", "throwing_arrow_2.png", "throwing_arrow.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "throwing:arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 3
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						groupcaps={
							fleshy={times={[1]=1/(damage-2), [2]=1/(damage-1), [3]=1/damage}},
							snappy={times={[1]=1/(damage-2), [2]=1/(damage-1), [3]=1/damage}},
						}
					}, nil)
					self.object:remove()
				end
			else
				local damage = 3
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					groupcaps={
						fleshy={times={[1]=1/(damage-2), [2]=1/(damage-1), [3]=1/damage}},
						snappy={times={[1]=1/(damage-2), [2]=1/(damage-1), [3]=1/damage}},
					}
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'throwing:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("throwing:arrow_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'throwing:arrow 16',
	recipe = {
		{'default:stick', 'default:stick', 'default:steel_ingot'},
	}
})
