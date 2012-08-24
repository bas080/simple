-- CHESS MOD
-- ======================================
-- chess/init.lua
-- ======================================
-- Registers the basic chess stuff
--
-- Contents:
--
-- [regis] Spawn Block
-- [craft] Spawn Block
-- [regis] board_black
-- [regis] board_white
-- ======================================

dofile(minetest.get_modpath("chess").."/pieces.lua")
dofile(minetest.get_modpath("chess").."/rules.lua")

-- Register the spawn block
minetest.register_node("chess:spawn",{
    description = "Chess Board",
    tile_images = {"chess_spawn.png"},
    inventory_image = "chess_spawn.png",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
    after_dig_node = function(pos, node, digger)
        
        local size = 10
        
        local p = {x=pos.x+1, y=pos.y, z=pos.z+1}
        local n = minetest.env:get_node(p)
        
        if n.name == "chess:board_black" then 
            for i = size, 1, -1 do
                for ii = size, 1, -1 do
                    local p = {x=pos.x+i, y=pos.y, z=pos.z+ii}
                    minetest.env:remove_node(p)
                end
            end
        end
    end,
    on_punch = function(pos)
        
        --reset the pieces
        
    end,
    after_place_node = function(pos)
        
        local size = 10
        local isFree = true
        --check if there is room for a chessboard with pieces ontop
        for i = size, 1, -1 do
            for ii = size, 1, -1 do
                
                local p = {x=pos.x+i, y=pos.y, z=pos.z+ii}
                local n = minetest.env:get_node(p)

                local p_top = {x=pos.x+i, y=pos.y+1, z=pos.z+ii}
                local n_top = minetest.env:get_node(p_top)
                
                if n.name ~= "air" and n_top.name ~= "air" then 
                    isFree = false
                    break
                end
                
            end
        end
        
        local alternate = true
        
        if isFree then -- if there is room for a chessboard make the chessboard with pieces
            minetest.chat_send_all("Chess board has been placed, let the match begin!")
            for i = size, 1, -1 do
                for ii = size, 1, -1 do
                    
                    local p = {x=pos.x+i, y=pos.y, z=pos.z+ii}
                    
                    if (ii == 1) or (ii == size) or (i ==1) or (i == size) then--create border
                        minetest.env:add_node(p, {name="chess:board_black"})
                    else
                        if alternate then
                            minetest.env:add_node(p, {name="chess:board_black"})
                            alternate = false
                        else
                            minetest.env:add_node(p, {name="chess:board_white"})
                            alternate = true
                        end
                    end
                end
                
                if (math.floor(size/2) == size/2) then
                    if alternate then
                        alternate = false
                    else
                        alternate = true
                    end
                end
            end
        else
            minetest.chat_send_all("Chess board does not fit")
        end
	end,
})

-- Add crafting for the spawn block
minetest.register_craft({
    output="chess:spawn",
    recipe = {
        {'default:mese','default:mese','default:mese'},
        {'default:mese','default:mese','default:mese'},
        {'default:mese','default:mese','default:mese'},
    }
})

--Register the Board Blocks: white
minetest.register_node("chess:board_white",{
    description = "White Chess Board Piece",
    tile_images = {"chess_board_white.png"},
    inventory_image = "chess_white.png",
    groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
})

--Register the Board Blocks: black
minetest.register_node("chess:board_black",{
    description = "Black Chess Board Piece",
    tile_images = {"chess_board_black.png"},
    inventory_image = "chess_black.png",
    groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
})
