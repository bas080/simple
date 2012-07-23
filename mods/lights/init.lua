GLOWLIKE = function(nodeid,nodename,drawtype)
	if drawtype == nil then 
		drawtype = 'glasslike'
		inv_image = minetest.inventorycube("lights_"..nodeid..".png")
	else 
		inv_image = "lights_"..nodeid..".png" 
	end
	minetest.register_node("lights:"..nodeid, {
		description = nodename,
		drawtype = drawtype,
		tile_images = {"lights_"..nodeid..".png"},
		inventory_image = inv_image,
		light_propagates = true,
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15	,
		is_ground_content = true,
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
	})
end


-- ***********************************************************************************
--		FUNCTIONS							**************************************************
-- ***********************************************************************************
searchlight = function(pos)
			for i = 1, 30, 1 do
				local xm = {x=pos.x-i,y=pos.y-i,z=pos.z}
				local xp = {x=pos.x+i,y=pos.y-i,z=pos.z}
				local zm = {x=pos.x,y=pos.y-i,z=pos.z-i}
				local zp = {x=pos.x,y=pos.y-i,z=pos.z+i}
				local xmn  = minetest.env:get_node_or_nil(xm)
				local xpn  = minetest.env:get_node_or_nil(xp)
				local zmn  = minetest.env:get_node_or_nil(zm)
				local zpn  = minetest.env:get_node_or_nil(zp)

				if xmn ~= nil and xmn.name == "air"	then		
					minetest.env:add_node(xm,{type="node",name='lights:light'})
				end
				if xpn ~= nil and xpn.name == "air"	then		
					minetest.env:add_node(xp,{type="node",name='lights:light'})
				end
				if zmn ~= nil and zmn.name == "air"	then		
					minetest.env:add_node(zm,{type="node",name='lights:light'})
				end
				if zpn ~= nil and zpn.name == "air"	then		
					minetest.env:add_node(zp,{type="node",name='lights:light'})
				end
			end
end
searchlight_off = function(pos)
			for i = 1, 30, 1 do
				local xm = {x=pos.x-i,y=pos.y-i,z=pos.z}
				local xp = {x=pos.x+i,y=pos.y-i,z=pos.z}
				local zm = {x=pos.x,y=pos.y-i,z=pos.z-i}
				local zp = {x=pos.x,y=pos.y-i,z=pos.z+i}
				local xmn  = minetest.env:get_node_or_nil(xm)
				local xpn  = minetest.env:get_node_or_nil(xp)
				local zmn  = minetest.env:get_node_or_nil(zm)
				local zpn  = minetest.env:get_node_or_nil(zp)

				if xmn ~= nil and xmn.name == 'lights:light' then
					minetest.env:remove_node(xm)
				end
				if xpn ~= nil and xpn.name == 'lights:light' then
					minetest.env:remove_node(xp)
				end
				if zmn ~= nil and zmn.name == 'lights:light' then
					minetest.env:remove_node(zm)
				end
				if zpn ~= nil and zpn.name == 'lights:light' then
					minetest.env:remove_node(zp)
				end
			end
end
spotlight = function(pos,node)

			for i = 1, 19, 1 do
				local ontop = {x=pos.x,y=pos.y+i,z=pos.z}
				local is_air  = minetest.env:get_node_or_nil(ontop)

				if is_air ~= nil and is_air.name == "air"	then		
					minetest.env:add_node(ontop,{type="node",name='lights:light'})
				end
			end
end

spotlight_off = function(pos,node)
			for i = 1, 19, 1 do
				local ontop = {x=pos.x,y=pos.y+i,z=pos.z}
				local is_air  = minetest.env:get_node_or_nil(ontop)
				if is_air ~= nil and is_air.name == 'lights:light' then
					minetest.env:remove_node(ontop)
				end
			end
end

-- ***********************************************************************************
--		DEFS									**************************************************
-- ***********************************************************************************
GLOWLIKE('glowyellow','Yellow Glow Glass')
GLOWLIKE('glowgreen','Green Glow Glass')
GLOWLIKE('glowblue','Blue Glow Glass')
GLOWLIKE('glowred','Red Glow Glass')
GLOWLIKE('fancylamp','Fancy Lamp','plantlike')

minetest.register_node("lights:light", {
	drawtype = "glasslike",
	tile_images = {"lights_spotlights_inv.png"},
	inventory_image = minetest.inventorycube("lights_spotlights_inv.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15	,
	selection_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
})
minetest.register_node("lights:searchlight", { 
	description = 'Searchlight', 
	drawtype = "plantlike", 
	tile_images = {'lights_searchlight.png'}, 
	inventory_image = 'lights_searchlight.png',	
	wield_image = 'lights_searchlight.png', 
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'lights:searchlight_off',
	on_punch = function(pos,node)
		searchlight_off(pos)
		minetest.env:add_node(pos, {name='lights:searchlight_off'})
	end,
	on_dig = function(pos,node)
		searchlight_off(pos)
	end,
})
minetest.register_node("lights:searchlight_off", { 
	description = 'Searchlight', 
	drawtype = "plantlike", 
	tile_images = {'lights_searchlight.png'}, 
	inventory_image = 'lights_searchlight.png',	
	wield_image = 'lights_searchlight.png', 
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch =  function(pos,node)
		searchlight(pos)
		minetest.env:add_node(pos, {name='lights:searchlight'})
	end,
})			
minetest.register_node("lights:spotlight", {
	description = "Spotlight",
	tile_images = { "lights_spotlights_top.png", "lights_spotlights_side.png", "lights_spotlights_side.png"},
	inventory_image = minetest.inventorycube("lights_spotlights_top.png","lights_spotlights_side.png","lights_spotlights_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	drop = 'lights:spotlight_off',
	on_punch = function(pos,node)
		spotlight_off(pos)
		minetest.env:add_node(pos, {name='lights:spotlight_off'})
	end,
	on_dig = function(pos,node)
		spotlight_off(pos)
	end,
})
minetest.register_node("lights:spotlight_off", {
	description = "Spotlight",
	tile_images = { "lights_spotlights_top.png", "lights_spotlights_side.png", "lights_spotlights_side.png"},
	inventory_image = minetest.inventorycube("lights_spotlights_top.png","lights_spotlights_side.png","lights_spotlights_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	on_punch =  function(pos,node)
		spotlight(pos)
		minetest.env:add_node(pos, {name='lights:spotlight'})
	end,	
})


minetest.register_craft({	output = 'node "lights:glowyellow" 1',	recipe = {
		{'','glass',''},
		{'','torch',''},
		{'','glass',''},
	}})
minetest.register_craft({	output = 'node "lights:glowgreen" 1',	recipe = {
	{'','',''},
	{'','lights:glowyellow',''},
	{'','',''},
}})
minetest.register_craft({	output = 'node "lights:glowred" 1',	recipe = {
	{'','',''},
	{'','lights:glowgreen',''},
	{'','',''},
}})
minetest.register_craft({	output = 'node "lights:glowblue" 1',	recipe = {
	{'','',''},
	{'','lights:glowred',''},
	{'','',''},
}})
minetest.register_craft({	output = 'node "lights:glowyellow" 1',	recipe = {
	{'','',''},
	{'','lights:glowblue',''},
	{'','',''},
}})
minetest.register_craft({	output = 'node "lights:spotlight" 1',	recipe = {
	{'','glass',''},
	{'','lights:glowyellow',''},
	{'','lights:glowyellow',''},
}})
minetest.register_craft({	output = 'node "lights:searchlight" 1',	recipe = {
	{'lights:glowyellow','lights:glowyellow','lights:glowyellow'},
	{'glass','glass','glass'},
	{'','',''},
}})
minetest.register_craft({	output = 'node "lights:fancylamp" 1',	recipe = {
	{'','default:steel_ingot',''},
	{'','lights:glowyellow',''},
	{'','glass',''},
}})
