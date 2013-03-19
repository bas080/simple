-- Home Decor mod by VanessaE
-- 2013-03-17
--
-- Mostly my own code, with bits and pieces lifted from Minetest's default
-- lua files and from ironzorg's flowers mod.  Many thanks to GloopMaster
-- for helping me figure out the inventories used in the nightstands/dressers.
--
-- The code for ovens, nightstands, refrigerators are basically modified 
-- copies of the code for chests and furnaces.
--
-- License: LGPL 2.0 or higher
--

local DEBUG = 0

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua")
    S = intllib.Getter(minetest.get_current_modname())
else
    S = function ( s ) return s end
end

-- Various Functions

local dbg = function(s)
	if DEBUG == 1 then
		print('[HomeDecor] ' .. s)
	end
end

function homedecor_node_is_owned(pos, placer)
	local ownername = false
	if type(IsPlayerNodeOwner) == "function" then					-- node_ownership mod
		if HasOwner(pos, placer) then						-- returns true if the node is owned
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				if type(getLastOwner) == "function" then		-- ...is an old version
					ownername = getLastOwner(pos)
				elseif type(GetNodeOwnerName) == "function" then	-- ...is a recent version
					ownername = GetNodeOwnerName(pos)
				else
					ownername = S("someone")
				end
			end
		end

	elseif type(isprotect)=="function" then 					-- glomie's protection mod
		if not isprotect(5, pos, placer) then
			ownername = S("someone")
		end
	end

	if ownername ~= false then
		minetest.chat_send_player( placer:get_player_name(), S("Sorry, %s owns that spot."):format(ownername) )
		return true
	else
		return false
	end
end

dofile(minetest.get_modpath("homedecor").."/nodes.lua")					-- the catch-all for all misc nodes
dofile(minetest.get_modpath("homedecor").."/tables.lua")
dofile(minetest.get_modpath("homedecor").."/electronics.lua")
dofile(minetest.get_modpath("homedecor").."/shutters.lua")
dofile(minetest.get_modpath("homedecor").."/shingles.lua")

dofile(minetest.get_modpath("homedecor").."/door_models.lua")
dofile(minetest.get_modpath("homedecor").."/door_nodes.lua")

dofile(minetest.get_modpath("homedecor").."/signs_lib.lua")
dofile(minetest.get_modpath("homedecor").."/fences.lua")

dofile(minetest.get_modpath("homedecor").."/lighting.lua")
dofile(minetest.get_modpath("homedecor").."/kitchen_cabinet.lua")
dofile(minetest.get_modpath("homedecor").."/refrigerator.lua")
dofile(minetest.get_modpath("homedecor").."/oven.lua")
dofile(minetest.get_modpath("homedecor").."/nightstands.lua")

dofile(minetest.get_modpath("homedecor").."/crafts.lua")

dofile(minetest.get_modpath("homedecor").."/locked.lua")

print("[HomeDecor] "..S("Loaded!"))
