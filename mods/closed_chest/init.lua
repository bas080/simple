--[[

closed by key

Copyright (c) 2013 pandaro <padarogames@gmail.com>

Source Code:
License: GPLv3
pictures:WTFPL

CHEST
and
KEY
and
KEYRING	
and
KEY-MANAGER

]]--
--TO DO:more comments

-- expose api

local function has_locked_chest_privilege(meta, player)--metti un return per ogni blocco in modo che interrompa la ricerca(return true o false---
  local player_inv = player:get_inventory()
  local player_list= player_inv:get_list("main")
  local chest_inv= meta:get_inventory()
  local chest_list= chest_inv:get_list("main")
  local key_required=meta:get_string("key_required")
  if chest_inv:contains_item("main",{name="closed_chest:key"})==false and player_inv:contains_item("main",{name="closed_chest:key"})== false and chest_inv :contains_item("main",{name="closed_chest:full_keyring"})==false and player_inv :contains_item("main",{name="closed_chest:full_keyring"})==false then
    return false
  end
  if chest_inv :contains_item("main",{name="closed_chest:full_keyring"})==true then
    for i,v in ipairs (chest_list) do
      if v:get_name() =="closed_chest:full_keyring" then
	local keychain = v:get_metadata():split("*")
	for ii,vv in ipairs (keychain) do
	  if vv==key_required then
	    return true		    
	  end
	end
      end
    end
  end
  if player_inv :contains_item("main",{name="closed_chest:full_keyring"})==true then
    for i,v in ipairs (player_list) do
      if v:get_name() =="closed_chest:full_keyring" then
	local keychain = v:get_metadata():split("*")
	for ii,vv in ipairs (keychain) do
	  if vv==key_required then
	    return true		    
	  end
	end
      end
    end
  end
  if chest_inv:contains_item("main",{name="closed_chest:key"})==true then
    for i,v in ipairs (chest_list) do
      if v:get_name() =="closed_chest:key"then
	if v:get_metadata()==meta:get_string("key_required") then
	  return true
	end
      end
    end
  end
  if player_inv:contains_item("main",{name="closed_chest:key"})==true then
    for i,v in ipairs (player_list) do
      if v:get_name() =="closed_chest:key"then
	if v:get_metadata()==meta:get_string("key_required") then
	  print("you have the key")
	  return true
	end
      end
    end
  end
  return false
end
	
local function make(meta)
  local inv=meta:get_inventory()
  local main =inv:get_list("main")
  local slot=inv:get_stack("slot",1)
  local keychain=""
  if slot:get_name()=="closed_chest:empty_keyring" and slot:get_count()==1  then
    if inv:contains_item("main",{name="closed_chest:key"}) ==true then      
      for i,v in ipairs (main) do
	if v:get_name()=="closed_chest:key" then		
	  keychain=(tostring(keychain).."*"..(tostring(v:get_metadata())))
	  inv:set_stack("main",i,{})	  
	end
      end
    inv:set_stack("slot",1,{name="closed_chest:full_keyring",count=1,metadata=keychain})
    end
  end  
end 

local function unmake(meta)
  local inv=meta:get_inventory()
  local slot=inv:get_stack("slot",1)  
  local main =inv:get_list("main")
  if slot:get_name()=="closed_chest:full_keyring"then
    local keychain = slot:get_metadata():split("*")
    local count = table.getn(keychain)
    local empty=0
    for i,v in ipairs (main) do
      if v:get_count()<=0 then
	empty=empty+1
	if empty >= count then
	  empty= true
	  break
	end
      end
    end    
    if empty==true then      
      for i,v in ipairs (keychain) do
	inv:add_item("main",{name="closed_chest:key",metadata=v})
      end
    inv:set_stack("slot",1,{name="closed_chest:empty_keyring"})      
    end    
  end  
end

local function copy(meta)
  local inv=meta:get_inventory()
  local keyslot=inv:get_stack("slot",1)  
  local main=inv:get_list("main")
  local keycode=(keyslot:get_metadata())
  if keyslot:get_name()=="closed_chest:key" then
    if inv:contains_item("main",{name="steel_ingot"}) then
      if inv:room_for_item("main",{name="closed_chest:key"})== true then
	inv:add_item("main",{name="closed_chest:key",metadata=keycode})
	inv:remove_item("main",{name="steel_ingot"})	
      end
    end
  elseif keyslot:get_name()=="closed_chest:full_keyring" then
    if inv:contains_item("main",{name="closed_chest:empty_keyring"}) then
      local keys = keycode:split("*")
      local count=table.getn(keys)
      if inv:contains_item("main",{name="steel_ingot",count=count}) then
	if inv:room_for_item("main",{name="closed_chest:empty_keyring"}) then
	  inv:remove_item("main",{name="closed_chest:empty_keyring"})
	  inv:add_item("main",{name="closed_chest:full_keyring",metadata=keycode})
	  inv:remove_item("main",{name="steel_ingot",count=count})	  
	end
      end
    end
  end
end	
  

minetest.register_node("closed_chest:key", {
	description = "key",
	tiles = {"key.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'closed_chest:key',
	legacy_mineral = true,
	stack_max = 1,
	pointable=true,
	
	after_place_node=function(pos,placer,itemstack)	
	  local meta=minetest.env:get_meta(pos)
	  meta:set_string("key",itemstack:to_table().metadata)
	  meta:set_string("infotext", "key " ..tostring(meta:get_string("key")).. "")
	end,
	
	after_dig_node=function(pos,oldnode,oldmetadata,digger)	  
	  meta_before_dig=(oldmetadata.fields.key)
	  local inv = digger:get_inventory()
	  local list=(inv:get_list("main"))
	  for i,v in ipairs (list) do
	    if v:get_name() =="closed_chest:key" then
	      if v:get_metadata()=="" then
		inv:set_stack("main",i,{name="closed_chest:key",count=1,metadata=meta_before_dig})		
	      end
	    end
	  end
	end,
}) 


minetest.register_node("closed_chest:chest", {	
	description = "closed_chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "locked_chest_front.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'closed_chest:chest',
	legacy_mineral = true,
	stack_max = 99,
	paramtype2 = "facedir",
	legacy_facedir_simple=true,
	pointable=true,
	
	on_construct = function(pos)
		local meta=minetest.env:get_meta(pos)
		local key_random=math.random(1,1000)
		local k =tostring(key_random)
		meta:set_string("key_required",k)
		meta:set_string("infotext", "closed chest " .. k .."")
		--minetest.env:place_node({x=pos.x,y=pos.y+1,z=pos.z},{name="closed_chest:key"})
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_stack("main",1,{name="closed_chest:key",metadata=k})
		meta:set_string("formspec",				
				"size[9,10]"..
				"label[0,0;chest "..k.."]"..
				"list[current_name;main;0,1;8,4;]"..				
				"list[current_player;main;0,6;8,4;]")		
	end,
	    
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")

	end,
	  
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			--meta:set_string("formspec", closed)
			minetest.log("action", player:get_player_name()..
					" attempt to access the closed chest: "..
					meta:get_string("key_required").." at "..
					minetest.pos_to_string(pos))
			return 0
		end		
		return stack:get_count()
	end,
	    
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)		
		if not has_locked_chest_privilege(meta, player) then
			--meta:set_string("formspec", closed)
			minetest.log("action", player:get_player_name()..
					" attempt to access the closed chest: "..
					meta:get_string("key_required").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,	    
	    
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			--meta:set_string("formspec", closed)
			minetest.log("action", player:get_player_name()..
					" attempt to access the closed chest: "..
					meta:get_string("key_required").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	    
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
	end,
	    
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
	end,
	    
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
	end,
})

	
minetest.register_node("closed_chest:empty_keyring", {	
	description = "empty keyring",
	tiles = {"empty_keyring.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'closed_chest:empty_keyring',
	legacy_mineral = true,
	stack_max = 99,
	legacy_facedir_simple=true,
})
	
minetest.register_node("closed_chest:full_keyring", {	
	description = "full_keyring",
	tiles = {"full_keyring.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'closed_chest:full_keyring',
	legacy_mineral = true,
	stack_max = 1,
	legacy_facedir_simple=true,

	after_place_node=function(pos,placer,itemstack)	
	  local meta=minetest.env:get_meta(pos)
	  meta:set_string("keyring",itemstack:to_table().metadata)
	  meta:set_string("infotext", "keyring " ..tostring(meta:get_string("keyring")).. "")
	end,

	after_dig_node=function(pos,oldnode,oldmetadata,digger)	  
	  meta_before_dig=(oldmetadata.fields.keyring)
	  local inv = digger:get_inventory()
	  local list=(inv:get_list("main"))
	  for i,v in ipairs (list) do
	    if v:get_name() =="closed_chest:full_keyring" then
	      if v:get_metadata()=="" then
		inv:set_stack("main",i,{name="closed_chest:full_keyring",count=1,metadata=meta_before_dig})		
	      end
	    end
	  end
	end,
})	
	
minetest.register_node("closed_chest:key_manager", {	
	description = "key manager",
	tiles = {"key_manager.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = 'closed_chest:key_manager',
	legacy_mineral = true,
	stack_max = 99,
	paramtype2 = "facedir",
	legacy_facedir_simple=true,
	
	on_construct=function(pos)
	  local meta=minetest.env:get_meta(pos)
	  local inv = meta:get_inventory()
	  inv:set_size("main", 8*4)
	  inv:set_size("slot", 1*1)
	  meta:set_string("formspec",		  
		  "size[12,9]"..
		  "list[current_name;main;0,0;8,4;]"..
		  "list[current_name;slot;2,4;1,1;]"..
		  "list[current_player;main;0,5;8,4;]"..
		  "button[0,4;2,1;make;make]"..
		  "button[6,4;2,1;copy;copy]"..
		  "button[3,4;2,1;unmake;unmake]")		  
	end,
	
	on_receive_fields=function(pos,formname,fields,sender)	  
	  if fields.make== "make" then
	    meta=minetest.env:get_meta(pos)
	    make(meta)	    
	  end	  
	  if fields.unmake== "unmake" then
	    meta=minetest.env:get_meta(pos)
	    unmake(meta)
	  end
	  if fields.copy== "copy" then
	    meta=minetest.env:get_meta(pos)
	    copy(meta)
	  end
	end,
	
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", player:get_player_name()..
					" moves stuff in locked chest at "..minetest.pos_to_string(pos))		
	end,	    
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
	end,
})
	
minetest.register_craft({
	inventory_image='locked_chest_front.png',
	stack_max =99,
	output = 'closed_chest:chest',
	recipe = {
		{'default:steel_ingot'},
		{'default:chest',},		
	}	
})

minetest.register_craft({
	inventory_image='empty_keyring.png',
	stack_max =99,
	output = 'closed_chest:empty_keyring',
	recipe = {
		{'default:dry_shrub','','default:dry_shrub'},
		{'','default:dry_shrub',''},
		{'default:dry_shrub','','default:dry_shrub'},
	}	
})

minetest.register_craft({
	inventory_image='key_manager.png',
	stack_max =99,
	output = 'closed_chest:key_manager',
	recipe = {
		{'','default:mese',''},
		{'','default:chest',''},
	}	
})