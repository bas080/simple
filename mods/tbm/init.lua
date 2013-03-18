-- a tunnel boring machine

tbm = {}

-- offsets to determine block positions
-- access as [facedir][y][x].X for X offset from current position
-- Y for Y offset from current position and Z for Z offset etc.
-- This is a easy way to determine the 4x4 box that should be
-- mined from the current position based on the current facedir
tbm.offsets = 
		{ -- facedir indexed (+1)
			{ -- facedir = 0
				{ -- first line
					{ X = -1, Y =  2, Z =  1 },
					{ X =  0, Y =  2, Z =  1 },
					{ X =  1, Y =  2, Z =  1 }
				},
				{ -- second line
					{ X = -1, Y =  1, Z =  1 },
					{ X =  0, Y =  1, Z =  1 },
					{ X =  1, Y =  1, Z =  1 }
				},
				{ -- third line
					{ X = -1, Y =  0, Z =  1 },
					{ X =  0, Y =  0, Z =  1 },
					{ X =  1, Y =  0, Z =  1 }
				},
				{ -- forth line
					{ X = -1, Y = -1, Z =  1 },
					{ X =  0, Y = -1, Z =  1 },
					{ X =  1, Y = -1, Z =  1 }
				}
			},
			{ -- facedir = 1
				{ -- first line
					{ X =  1, Y =  2, Z = -1 },
					{ X =  1, Y =  2, Z =  0 },
					{ X =  1, Y =  2, Z =  1 }
				},
				{ -- second line
					{ X =  1, Y =  1, Z = -1 },
					{ X =  1, Y =  1, Z =  0 },
					{ X =  1, Y =  1, Z =  1 }
				},
				{ -- third line
					{ X =  1, Y =  0, Z = -1 },
					{ X =  1, Y =  0, Z =  0 },
					{ X =  1, Y =  0, Z =  1 }
				},
				{ -- forth line
					{ X =  1, Y = -1, Z = -1 },
					{ X =  1, Y = -1, Z =  0 },
					{ X =  1, Y = -1, Z =  1 }
				}
			},
			{ -- facedir = 2
				{ -- first line
					{ X = -1, Y =  2, Z = -1 },
					{ X =  0, Y =  2, Z = -1 },
					{ X =  1, Y =  2, Z = -1 }
				},
				{ -- second line
					{ X = -1, Y =  1, Z = -1 },
					{ X =  0, Y =  1, Z = -1 },
					{ X =  1, Y =  1, Z = -1 }
				},
				{ -- third line
					{ X = -1, Y =  0, Z = -1 },
					{ X =  0, Y =  0, Z = -1 },
					{ X =  1, Y =  0, Z = -1 }
				},
				{ -- forth line
					{ X = -1, Y = -1, Z = -1 },
					{ X =  0, Y = -1, Z = -1 },
					{ X =  1, Y = -1, Z = -1 }
				}
			},
			{ -- facedir = 3
				{ -- first line
					{ X = -1, Y =  2, Z = -1 },
					{ X = -1, Y =  2, Z =  0 },
					{ X = -1, Y =  2, Z =  1 }
				},
				{ -- second line
					{ X = -1, Y =  1, Z = -1 },
					{ X = -1, Y =  1, Z =  0 },
					{ X = -1, Y =  1, Z =  1 }
				},
				{ -- third line
					{ X = -1, Y =  0, Z = -1 },
					{ X = -1, Y =  0, Z =  0 },
					{ X = -1, Y =  0, Z =  1 }
				},
				{ -- forth line
					{ X = -1, Y = -1, Z = -1 },
					{ X = -1, Y = -1, Z =  0 },
					{ X = -1, Y = -1, Z =  1 }
				}
			}
		}

tbm.newposline = 3
tbm.newposcolumn = 2
tbm.rowbelownewpos = 4

tbm.placetbm = function(pos, fuel)
	-- will correctly pace a TBM at the position indicated
	local meta = minetest.env:get_meta(pos)
	meta:set_string("formspec",
			"size[8,9]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
	meta:set_string("infotext", "Tunnel Boring Machine - " .. fuel)
	meta:set_string("fuel", fuel)
	local inv = meta:get_inventory()
	inv:set_size("main", 8*4)
end

tbm.findnewpos = function(pos, facing)
	-- will return the position where the machine will go in the next cicle
	local newpos = {}
	local box = tbm.offsets[facing + 1]
	newpos.x = pos.x + box[tbm.newposline][tbm.newposcolumn].X
	newpos.y = pos.y + box[tbm.newposline][tbm.newposcolumn].Y
	newpos.z = pos.z + box[tbm.newposline][tbm.newposcolumn].Z
	return newpos
end

tbm.findoldpos = function(pos, facing)
	-- will return the position where the machine was before (to drop items)
	local oldpos = {}
	if facing==0 then
		oldpos.x = pos.x
		oldpos.z = pos.z - 1
		oldpos.y = pos.y
	elseif facing==1 then
		oldpos.x = pos.x - 1
		oldpos.z = pos.z
		oldpos.y = pos.y
	elseif facing==2 then
		oldpos.x = pos.x
		oldpos.z = pos.z + 1
		oldpos.y = pos.y
	else
		oldpos.x = pos.x + 1
		oldpos.z = pos.z
		oldpos.y = pos.y
	end;
	return oldpos
end

tbm.dropitem = function(pos, item)
    -- Take item in any format
    local stack = ItemStack(item)
    local obj = minetest.env:add_entity(pos, "__builtin:item")
    obj:get_luaentity():set_item(stack:to_string())
    return obj
end

tbm.findstack = function(inv, name)
	-- will find name in the inventory inv and return its stack or nil
	local h = 0
	if not inv:is_empty("main") then
		for h = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", h)
			if stack:get_name() == name then
				return stack
			end
		end
	else
		return nil
	end
end

tbm.getstackcount = function(pos, name)
	-- will return the ammount of name in all stacks at position pos
	local h = 0
	local inv = minetest.env:get_meta(pos):get_inventory()
	local found = 0
	if not inv:is_empty("main") then
		for h = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", h)
			if stack:get_name() == name then
				if not stack:is_empty() then
					found = found + stack:get_count()
				end
			end
		end
	end
	return found
end

tbm.setstackcount = function(pos, name, count)
	-- will make n stacks at position pos so that they
	-- together makes up for count items of the item name
	local inv = minetest.env:get_meta(pos):get_inventory()
	local found = tbm.getstackcount(pos, name) + count
	local numberofstacks = math.floor(found / 99)
	local laststacksize = found % 99
	local h = 0
	for h = 1, numberofstacks do
		inv:add_item("main", name.." 99")
	end
	inv:add_item("main", name.." "..laststacksize)
end

tbm.breakstones = function(pos, facing)
	-- will break all stones in front of the machine
	local block = tbm.offsets[facing + 1]
	local i = 1
	local j = 1
	local bpos = {}
	local oldpos = tbm.findoldpos(pos, facing)
	local cobbleresult = 0
	for i = 1, 3 do
		for j = 1, 3 do
			bpos.x = pos.x + block[i][j].X
			bpos.y = pos.y + block[i][j].Y
			bpos.z = pos.z + block[i][j].Z
			local current = minetest.env:get_node(bpos)
			if current.name ~= 'air' and current.name ~= 'ignore' then 
				if current.name == "default:mese" then
					tbm.dropitem(oldpos, "default:mese")
				else
					local dropped = ItemStack({name=current.name}):get_definition().drop
					if dropped ~= "default:cobble" then
						tbm.dropitem(oldpos, dropped)
					else
						cobbleresult = cobbleresult + 1
					end
				end
				minetest.env:dig_node(bpos)
			end
		end
	end
	return cobbleresult
end

tbm.placecobble = function(pos, facing)
	-- place cobblestone below where the machine will be
	local box = tbm.offsets[facing + 1]
	local i = 1
	local ppos = {}
	for i = 1, 3 do
		ppos.x = pos.x + box[tbm.rowbelownewpos][i].X
		ppos.y = pos.y + box[tbm.rowbelownewpos][i].Y
		ppos.z = pos.z + box[tbm.rowbelownewpos][i].Z
		minetest.env:add_node(ppos, { name = "default:cobble" })
	end
end

tbm.placetorch = function(pos, facing)
	-- places a torch besides the track
	local box = tbm.offsets[facing + 1]
	local ppos = {}
	ppos.x = pos.x + box[tbm.newposline][1].X
	ppos.y = pos.y + box[tbm.newposline][1].Y
	ppos.z = pos.z + box[tbm.newposline][1].Z
	minetest.env:place_node(ppos, { name = "default:torch" })
end

tbm.placetrack = function(pos, facing)
	-- places a track behind the machine
	-- checks if carts mod is present
	local ppos = tbm.findoldpos(pos, facing)
	minetest.env:place_node(ppos, { name = "default:rail" } )
end

minetest.register_node("tbm:tbm", {
	description = "Tunnel Boring Machine",
	tiles = {"tbm_tbm.png"},
	paramtype = 'none',
	paramtype2 = 'facedir',
	groups = {
			snappy=2,
			choppy=2,
			oddly_breakable_by_hand=2
		},
	on_construct = function(pos)
		tbm.placetbm(pos, "0")
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
})

minetest.register_craft({
	output = '"tbm:tbm" 1',
	recipe = {
		{'default:steel_ingot', 'default:pick_steel', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:furnace', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_abm(
	{
		nodenames = {"tbm:tbm"},
		interval = 10,
		chance = 1,
		action = function(pos)
			-- setup old and new position (for movement and item drops)
			local facing = minetest.env:get_node(pos).param2
			local lightcount = minetest.env:get_node(pos).param1
			local newpos = tbm.findnewpos(pos, facing)
			local oldpos = tbm.findoldpos(pos, facing)
			local coalcount = tbm.getstackcount(pos, "default:coal_lump")
			local cobblecount = tbm.getstackcount(pos, "default:cobble")
			local torchcount = tbm.getstackcount(pos, "default:torch")
			local railcount = tbm.getstackcount(pos, "default:rail")
			-- Current metadata
			local meta = minetest.env:get_meta(pos)
			-- Current inventory
			local inv = meta:get_inventory()
			local fuel = tonumber(meta:get_string("fuel"))
			if fuel == nil then
				fuel = 0
			end
			-- check fuel, if below 1, grab a coal if coal > 0 else, do nothing
			if fuel == 0 then
				if coalcount > 0 then
					fuel = 3
					coalcount = coalcount - 1
				end
			end
			-- only work if there is fuel, three cobblestones, one track and one torch
			if (fuel > 0) and (cobblecount > 2) and (railcount > 0) and (torchcount > 0) then
				fuel = fuel - 1
				-- break nodes ahead of the machine
				local addcobble = tbm.breakstones(pos, facing)
				-- put cobble to make bridges
				tbm.placecobble(pos, facing)
				cobblecount = cobblecount - 3
				if cobblecount < 99 then
					cobblecount = cobblecount + addcobble
				end
				-- put torchs every 8 blocks
				lightcount = lightcount + 1
				if lightcount >= 8 then
					if torchcount > 0 then
						tbm.placetorch(pos, facing)
						torchcount = torchcount - 1
					end
					lightcount = 0
				end
				if railcount > 0 then
					tbm.placetrack(pos, facing)
					railcount = railcount - 1
				end
				-- create new TBM at the new position 
				minetest.env:add_node(newpos, { name="tbm:tbm", param1=lightcount, param2=facing })
				-- create inventary and other meta data at the new position
				tbm.placetbm(newpos, tostring(fuel))
				-- move tbm stack to the new position
				tbm.setstackcount(newpos, "default:coal_lump", coalcount)
				tbm.setstackcount(newpos, "default:cobble", cobblecount)
				tbm.setstackcount(newpos, "default:torch", torchcount)
				tbm.setstackcount(newpos, "default:rail", railcount)
				-- remove tbm from old position
				minetest.env:remove_node(pos)
			end
		end
	})