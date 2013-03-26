---
---Protector+ Mod By Aqua! Based On Glomie's Original Protector Mod!
---

print("[Protector+] Loaded! By Aqua!")

minetest.register_craft({
	output = 'protectorplus:protect',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:chest_locked', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})


function isprotect(r,pos,digger,onlyowner)
	--[[
	if pos.y < -999 then
		return false
	end--]]
	local ok=true
	for ix = pos.x-r,pos.x+r do
		for iy = pos.y-r,pos.y+r do
			for iz = pos.z-r,pos.z+r do
				local node_name = minetest.env:get_node({x=ix,y=iy,z=iz})
				if node_name.name == "protectorplus:protect" then
					local meta = minetest.env:get_meta({x=ix,y=iy,z=iz})
					if digger ~= nil then
						local owner = (meta:get_string("owner"))					
							if owner ~= digger:get_player_name() then 
								ok=false
								if not onlyowner and string.find(' '..meta:get_string("members")..' ', ' '..digger:get_player_name()..' ')
								then ok=true end
								if not ok then return false end
							end
						end			
				end
			end
		end
	end
	return true
end

local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
	local ok=true
	if node.name ~= "protectorplus:protect" then
	ok = isprotect(5,pos,digger)
	else ok = isprotect(5,pos,digger,true)
	end
	if ok == true then
		old_node_dig(pos, node, digger)
	else
		minetest.chat_send_player(digger:get_player_name(), "area protected")
		return
	end
end

local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() ~= "protectorplus:protect" then
			local pos = pointed_thing.above
			ok = isprotect(5,pos,placer)
		else
			local pos = pointed_thing.above
			ok = isprotect(10,pos,placer,true)
		end 
		if ok == true then
			if itemstack:get_name() == "protectorplus:protect" then
				local pos = pointed_thing.above
				--minetest.chat_send_player(placer:get_player_name(), "this block protect ( ".. 
				--tostring(pos.x-3) .. " to " .. tostring(pos.x+3).." , "..
				--tostring(pos.y-3) .. " to " .. tostring(pos.y+3).." , "..
				--tostring(pos.z-3) .. " to " .. tostring(pos.z+3).." )"
				--)
			end
			return old_node_place(itemstack, placer, pointed_thing)
		else
			minetest.chat_send_player(placer:get_player_name(), "area protected")
			return
		end	
	end	
	return old_node_place(itemstack, placer, pointed_thing)
end
protect = {}
minetest.register_node("protectorplus:protect", {
	description = "Protect",
	tile_images = {"protect.png"},
	groups = {cracky=3},
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Protect (owned by "..
				meta:get_string("owner")..")")
		meta:set_string("members", "")
		meta:set_string("formspec",
			"size[6,4]"..
			"label[0,0;Protect owned by "..meta:get_string("owner").."]"..
			"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
			"button_exit[0,2;2,1;ok;Save]")
	end,
	on_receive_fields = function(pos,formname,fields,sender)
		local meta = minetest.env:get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			if fields.members then
				meta:set_string("members",fields.members)
				meta:set_string("formspec",
					"size[6,4]"..
					"label[0,0;Protect owned by "..meta:get_string("owner").."]"..
					"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
					"button_exit[0,2;2,1;ok;Save]")
		
			end
		end
	end,
})

---
---Bigger Protect
---

minetest.register_craft({
	output = 'protectorplus:bigger_protect',
	recipe = {
		{'protectorplus:protect'},
		{'protectorplus:protect'},
	}
})


function isprotect(r,pos,digger,onlyowner)
	--[[
	if pos.y < -999 then
		return false
	end--]]
	local ok=true
	for ix = pos.x-r,pos.x+r do
		for iy = pos.y-r,pos.y+r do
			for iz = pos.z-r,pos.z+r do
				local node_name = minetest.env:get_node({x=ix,y=iy,z=iz})
				if node_name.name == "protectorplus:bigger_protect" then
					local meta = minetest.env:get_meta({x=ix,y=iy,z=iz})
					if digger ~= nil then
						local owner = (meta:get_string("owner"))					
							if owner ~= digger:get_player_name() then 
								ok=false
								if not onlyowner and string.find(' '..meta:get_string("members")..' ', ' '..digger:get_player_name()..' ')
								then ok=true end
								if not ok then return false end
							end
						end			
				end
			end
		end
	end
	return true
end

local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
	local ok=true
	if node.name ~= "protectorplus:bigger_protect" then
	ok = isprotect(10,pos,digger)
	else ok = isprotect(10,pos,digger,true)
	end
	if ok == true then
		old_node_dig(pos, node, digger)
	else
		minetest.chat_send_player(digger:get_player_name(), "area protected")
		return
	end
end

local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() ~= "protectorplus:bigger_protect" then
			local pos = pointed_thing.above
			ok = isprotect(10,pos,placer)
		else
			local pos = pointed_thing.above
			ok = isprotect(20,pos,placer,true)
		end 
		if ok == true then
			if itemstack:get_name() == "protectorplus:bigger_protect" then
				local pos = pointed_thing.above
				--minetest.chat_send_player(placer:get_player_name(), "this block protect ( ".. 
				--tostring(pos.x-3) .. " to " .. tostring(pos.x+3).." , "..
				--tostring(pos.y-3) .. " to " .. tostring(pos.y+3).." , "..
				--tostring(pos.z-3) .. " to " .. tostring(pos.z+3).." )"
				--)
			end
			return old_node_place(itemstack, placer, pointed_thing)
		else
			minetest.chat_send_player(placer:get_player_name(), "area protected")
			return
		end	
	end	
	return old_node_place(itemstack, placer, pointed_thing)
end
bigger_protect = {}
minetest.register_node("protectorplus:bigger_protect", {
	description = "Bigger Protect",
	tile_images = {"bigger_protect.png"},
	groups = {cracky=3},
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Bigger Protect (owned by "..
				meta:get_string("owner")..")")
		meta:set_string("members", "")
		meta:set_string("formspec",
			"size[6,4]"..
			"label[0,0;Bigger Protect owned by "..meta:get_string("owner").."]"..
			"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
			"button_exit[0,2;2,1;ok;Save]")
	end,
	on_receive_fields = function(pos,formname,fields,sender)
		local meta = minetest.env:get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			if fields.members then
				meta:set_string("members",fields.members)
				meta:set_string("formspec",
					"size[6,4]"..
					"label[0,0;Bigger Protect owned by "..meta:get_string("owner").."]"..
					"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
					"button_exit[0,2;2,1;ok;Save]")
		
			end
		end
	end,
})

---
---Biggest Protect
---

minetest.register_craft({
	output = 'protectorplus:biggest_protect',
	recipe = {
		{'protectorplus:bigger_protect', 'protectorplus:bigger_protect'},
		{'protectorplus:bigger_protect', 'protectorplus:bigger_protect'},
	}
})


function isprotect(r,pos,digger,onlyowner)
	--[[
	if pos.y < -999 then
		return false
	end--]]
	local ok=true
	for ix = pos.x-r,pos.x+r do
		for iy = pos.y-r,pos.y+r do
			for iz = pos.z-r,pos.z+r do
				local node_name = minetest.env:get_node({x=ix,y=iy,z=iz})
				if node_name.name == "protectorplus:biggest_protect" then
					local meta = minetest.env:get_meta({x=ix,y=iy,z=iz})
					if digger ~= nil then
						local owner = (meta:get_string("owner"))					
							if owner ~= digger:get_player_name() then 
								ok=false
								if not onlyowner and string.find(' '..meta:get_string("members")..' ', ' '..digger:get_player_name()..' ')
								then ok=true end
								if not ok then return false end
							end
						end			
				end
			end
		end
	end
	return true
end

local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
	local ok=true
	if node.name ~= "protectorplus:biggest_protect" then
	ok = isprotect(20,pos,digger)
	else ok = isprotect(20,pos,digger,true)
	end
	if ok == true then
		old_node_dig(pos, node, digger)
	else
		minetest.chat_send_player(digger:get_player_name(), "area protected")
		return
	end
end

local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() ~= "protectorplus:biggest_protect" then
			local pos = pointed_thing.above
			ok = isprotect(20,pos,placer)
		else
			local pos = pointed_thing.above
			ok = isprotect(40,pos,placer,true)
		end 
		if ok == true then
			if itemstack:get_name() == "protectorplus:biggest_protect" then
				local pos = pointed_thing.above
				--minetest.chat_send_player(placer:get_player_name(), "this block protect ( ".. 
				--tostring(pos.x-3) .. " to " .. tostring(pos.x+3).." , "..
				--tostring(pos.y-3) .. " to " .. tostring(pos.y+3).." , "..
				--tostring(pos.z-3) .. " to " .. tostring(pos.z+3).." )"
				--)
			end
			return old_node_place(itemstack, placer, pointed_thing)
		else
			minetest.chat_send_player(placer:get_player_name(), "area protected")
			return
		end	
	end	
	return old_node_place(itemstack, placer, pointed_thing)
end
biggest_protect = {}
minetest.register_node("protectorplus:biggest_protect", {
	description = "Biggest Protect",
	tile_images = {"biggest_protect.png"},
	groups = {cracky=3},
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Biggest Protect (owned by "..
				meta:get_string("owner")..")")
		meta:set_string("members", "")
		meta:set_string("formspec",
			"size[6,4]"..
			"label[0,0;Biggest Protect owned by "..meta:get_string("owner").."]"..
			"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
			"button_exit[0,2;2,1;ok;Save]")
	end,
	on_receive_fields = function(pos,formname,fields,sender)
		local meta = minetest.env:get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			if fields.members then
				meta:set_string("members",fields.members)
				meta:set_string("formspec",
					"size[6,4]"..
					"label[0,0;Biggest Protect owned by "..meta:get_string("owner").."]"..
					"field[.25,1.25;6,1;members;Members (put spaces between each name):;"..meta:get_string("members").."]"..
					"button_exit[0,2;2,1;ok;Save]")
		
			end
		end
	end,
})