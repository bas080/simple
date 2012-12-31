-- CHESS MOD
-- ======================================
-- chess/pieces.lua
-- ======================================
-- Registers the chess pieces
--
-- Contents:
--
-- [loop] registers pieces
-- ======================================

local colors = {"black", "white",}

local piece_group = {snappy=3}

--make a loop which makes the black and white nodes and crafting recipes

for color = 1, 2 do
    --Pawn
    minetest.register_node("chess:pawn_"..colors[color],
    {
        description = 'Pawn ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
        {-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
        {-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
        {-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
        {-0.1, -0.3, -0.1, 0.1, 0.2, 0.1},
        {-0.2, -0.1, -0.1, 0.2, 0.1, 0.1},
        {-0.1, -0.1, -0.2, 0.1, 0.1, 0.2},
        },
        },
        selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3},
        },
        groups = piece_group
    })

    --Rook
    minetest.register_node("chess:rook_"..colors[color],
    {
        description = 'Rook ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
		{-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
		{-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
		{-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
		{-0.1, -0.3, -0.1, 0.1, 0.2, 0.1},
		{-0.1, 0.2, -0.2, 0.1, 0.3, 0.2 },
		{-0.2, 0.2, -0.1, 0.2, 0.3, 0.1},
		{-0.2, 0.3, -0.2, 0.2, 0.4, 0.2},
		{-0.2, 0.4, -0.2, -0.1, 0.5, -0.1},
		{-0.05, 0.4, -0.2, 0.05, 0.5, -0.1},
		{0.1, 0.4, -0.2, 0.2, 0.5, -0.1},
		{-0.2, 0.4, -0.05, -0.1, 0.5, 0.05},
		{0.1, 0.4, -0.05, 0.2, 0.5, 0.05},
		{-0.2, 0.4, 0.1, -0.1, 0.5, 0.2},
		{-0.05, 0.4, 0.1, 0.05, 0.5, 0.2},
		{0.1, 0.4, 0.1, 0.2, 0.5, 0.2},
        },
		},
		selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
        groups = piece_group
    })

    --Knight
    minetest.register_node("chess:knight_"..colors[color],
    {
        description = 'Knight ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
		{-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
		{-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
		{-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
		{-0.1, -0.3, -0.1, 0.1, 0.45, 0.1},
		{-0.1, -0.2, -0.2, 0.1, 0.1, 0.15},
		{-0.15, -0.2, -0.1, 0.15, 0.1, 0.1},
		{-0.1, 0.2, -0.25, 0.1, 0.35, 0.15},
		{-0.1, 0.45, 0.01, -0.07, 0.5, 0.06},
		{0.07, 0.45, 0.01, 0.1, 0.5, 0.06},
        },
		},
		selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
        groups = piece_group
    })

    --Bishop
    
    minetest.register_node("chess:bishop_"..colors[color],
    {
        description = 'Bishop ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
        {-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
		{-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
		{-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
		{-0.1, -0.3, -0.1, 0.1, 0.4, 0.1},
		{-0.1, 0, -0.2, 0.1, 0.1, 0.2},		
		{-0.2, 0, -0.1, 0.2, 0.1, 0.1},
		{-0.1, 0.15, -0.2, 0.1, 0.35, 0.2},
		{-0.2, 0.15, -0.1, 0.2, 0.35, 0.1 },
		{-0.05, 0.4, -0.05, 0.05, 0.5, 0.05},        
        },
        },
        selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        groups = piece_group
    })

    --Queen
    minetest.register_node("chess:queen_"..colors[color],
    {
        description = 'Queen ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
		{-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
		{-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
		{-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
		{-0.1, -0.3, -0.1, 0.1, 0.2, 0.1},
		{-0.1, 0, -0.2, 0.1, 0.1, 0.2},
		{-0.2, 0, -0.1, 0.2, 0.1, 0.1},
		{-0.1, 0.2, -0.2, 0.1, 0.4, 0.2},
		{-0.2, 0.2, -0.1, 0.2, 0.4, 0.1},
		{-0.07, 0.4, -0.19, 0.07, 0.44, -0.11},
		{-0.07, 0.4, 0.11, 0.07, 0.44, 0.19},
		{-0.19, 0.4, -0.07, -0.11, 0.44, 0.07},
		{0.11, 0.4, -0.07, 0.19, 0.44, 0.07},
		{-0.04, 0.4, -0.07, 0.04, 0.46, 0.07},
		{-0.07, 0.4, -0.04, 0.07, 0.46, 0.04},
		{-0.04, 0.46, -0.04, 0.04, 0.49, 0.04},
        },
		},
		selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
        groups = piece_group
    })

    --King
    minetest.register_node("chess:king_"..colors[color],
    {
        description = 'King ('..colors[color]..')',
        groups = {snappy = 2},
        tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
        drawtype = "nodebox",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        light_source = 8, --max light is 18
        node_box = {
        type = "fixed",
        fixed = {
		{-0.2, -0.5, -0.3, 0.2, -0.4, 0.3},
		{-0.3, -0.5, -0.2, 0.3, -0.4, 0.2},
		{-0.1, -0.4, -0.2, 0.1, -0.3, 0.2},
		{-0.2, -0.4, -0.1, 0.2, -0.3, 0.1},
		{-0.1, -0.3, -0.1, 0.1, 0.2, 0.1},
		{-0.1, 0, -0.2, 0.1, 0.1, 0.2},
		{-0.2, 0, -0.1, 0.2, 0.1, 0.1},
		{-0.1, 0.2, -0.2, 0.1, 0.4, 0.2},
		{-0.2, 0.2, -0.1, 0.2, 0.4, 0.1},
		{-0.02, 0.4, -0.02, 0.02, 0.5, 0.02},
		{-0.02, 0.43, -0.05, 0.02, 0.47, 0.05},
		{-0.05, 0.43, -0.02, 0.05, 0.47, 0.02},
        },
		},
		selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
        groups = piece_group
    })

end
