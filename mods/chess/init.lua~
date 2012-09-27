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

local letters = {"a", "b", "c", "d", "e", "f", "g", "h"}

local size = 9 --total width(10) including the border coordinate 0,0
local innerSize = 8 --inner width(8) including the coordinate 1,1

-- Register the spawn block
minetest.register_node("chess:spawn",{
    description = "Chess Board",
    tile_images = {"chess_border_spawn.png", "chess_board_black.png", "chess_board_black.png^chess_border_side.png"},
    inventory_image = "chess_spawn.png",
	  groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
    after_dig_node = function(pos, node, digger)
        
        local size = 9
        
        local p = {x=pos.x+1, y=pos.y, z=pos.z+1}
        local n = minetest.env:get_node(p)
        
        if n.name == "chess:board_black" then 
            for i = size, 0, -1 do
                for ii = size, 0, -1 do
                    
                    --remove board
                    local p = {x=pos.x+i, y=pos.y, z=pos.z+ii}
                    minetest.env:remove_node(p)
                    
                    --remove pieces ontop
                    local p = {x=pos.x+i, y=pos.y+1, z=pos.z+ii}
                    minetest.env:remove_node(p)
                    
                end
            end
        end
    end,
    on_punch = function(pos)
        
        --reset the pieces
        
    end,
    after_place_node = function(pos, placer)
        --place chess board
        
        local isFree = true
        
        for i = size, 0, -1 do
            for ii = size, 0, -1 do
                for iii = 1, 0, -1 do
                    if (isFree) then
                        
                        local p = {x=pos.x+i, y=pos.y+iii, z=pos.z+ii}
                        local n = minetest.env:get_node(p)
                        
                        if(n.name ~= "air" and n.name ~= "chess:spawn") then
                            isFree = false
                            minetest.chat_send_all("Cannot place chess board")
                        end
                    end
                end
            end
        end
        
        
        if (isFree) then
            minetest.chat_send_all("Chess board has been placed, let the match begin!")
            for i = size, 0, -1 do
                for ii = size, 0, -1 do
                    --place chessboard
                    local p = {x=pos.x+i, y=pos.y, z=pos.z+ii}
                    local p_top = {x=pos.x+i, y=pos.y+1, z=pos.z+ii}
                    
                    if (ii == 0) or (ii == size) or (i ==0) or (i == size) then --if border
                        
                        if (ii == 0) and (i < size) and (i > 0) then --letters
                            minetest.env:add_node(p, {name="chess:border_" .. letters[i]})
                        end
                        
                        if (i == 0) and (ii < size) and (ii > 0) then --letters
                            minetest.env:add_node(p, {name="chess:border_" .. ii})
                        end
                        
                        if (i == size) or (ii == size) then
                            minetest.env:add_node(p, {name="chess:border"})
                        end
                        
                        
                    else--if inside border
                        if (((ii+i)/2) == math.floor((ii+i)/2)) then
                            minetest.env:add_node(p, {name="chess:board_black"})
                        else
                            minetest.env:add_node(p, {name="chess:board_white"})
                        end
                    end
                    --place peaces
                    local face = 2
                    if (ii == 2) and (i>0) and (i<size) then --pawns
                        minetest.env:add_node(p_top, {name="chess:pawn_black", param2 = face})
                    end
                    
                    if (ii == 1) then --behind pawns
                        if (i == 1 or i == 8) then minetest.env:add_node(p_top, {name="chess:rook_black", param2 = face}) end
                        if (i == 2 or i == 7) then minetest.env:add_node(p_top, {name="chess:knight_black", param2 = face}) end
                        if (i == 3 or i == 6) then minetest.env:add_node(p_top, {name="chess:bishop_black", param2 = face}) end
                        if (i == 4) then minetest.env:add_node(p_top, {name="chess:queen_black", param2 = face}) end
                        if (i == 5) then minetest.env:add_node(p_top, {name="chess:king_black", param2 = face}) end
                    end

                    --white pieces
                    local face = 0
                    if (ii == 7) and (i>0) and (i<size) then --pawns
                        minetest.env:add_node(p_top, {name="chess:pawn_white", param2 = face})
                    end
                    
                    if (ii == 8) then --behind pawns
                        if (i == 1 or i == 8) then minetest.env:add_node(p_top, {name="chess:rook_white", param2 = face}) end
                        if (i == 2 or i == 7) then minetest.env:add_node(p_top, {name="chess:knight_white", param2 = face}) end
                        if (i == 3 or i == 6) then minetest.env:add_node(p_top, {name="chess:bishop_white", param2 = face}) end
                        if (i == 4) then minetest.env:add_node(p_top, {name="chess:queen_white", param2 = face}) end
                        if (i == 5) then minetest.env:add_node(p_top, {name="chess:king_white", param2 = face}) end
                    end
                end
            end
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
    inventory_image = "chess_board_white.png",
    groups = {indestructable},
})

--Register the Board Blocks: black
minetest.register_node("chess:board_black",{
    description = "Black Chess Board Piece",
    tile_images = {"chess_board_black.png"},
    inventory_image = "chess_board_black.png",
    groups = {indestructable},
})

minetest.register_node("chess:border",{
    description = "Black Chess Board Piece",
    tile_images = {"chess_board_black.png", "chess_board_black.png", "chess_board_black.png^chess_border_side.png"},
    inventory_image = "chess_board_black.png",
    groups = {indestructable},
})

for iii = innerSize, 1, -1 do
    print("chess_border_" .. letters[iii] .. ".png")
    minetest.register_node("chess:border_" .. letters[iii],{
        description = "White Chess Board Piece",
        tile_images = {"chess_board_black.png^chess_border_" .. letters[iii] .. ".png", "chess_board_black.png", "chess_board_black.png^chess_border_side.png"},
        inventory_image = "chess_board_white.png",
        groups = {indestructable},
    })
    
    print("chess_border_" .. iii .. ".png")
    minetest.register_node("chess:border_" .. iii,{
        description = "White Chess Board Piece",
        tile_images = {"chess_board_black.png^chess_border_" .. iii .. ".png", "chess_board_black.png", "chess_board_black.png^chess_border_side.png"},
        inventory_image = "chess_board_white.png",
        groups = {indestructable},
    })
end

