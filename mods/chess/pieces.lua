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
dofile(minetest.get_modpath("chess").."/ownership.lua")

local function is_owner(pos, name)
  local owner = minetest.env:get_meta(pos):get_string("owner")
  if owner == name then
    return true
  end
    return false
end

local colors = {"black", "white",}
local piece_group = {snappy=3,not_in_creative_inventory=1}
--make a loop which makes the black and white nodes and crafting recipes
for color = 1, 2 do
  --Pawn
  minetest.register_node("chess:pawn_"..colors[color],
  {
    description = 'Pawn ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8,
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
  })

  --Rook
  minetest.register_node("chess:rook_"..colors[color],
  {
    description = 'Rook ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8,
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
  })

  --Knight
  minetest.register_node("chess:knight_"..colors[color],
  {
    description = 'Knight ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8, 
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
  })

  --Bishop
  minetest.register_node("chess:bishop_"..colors[color],
  {
    description = 'Bishop ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8, 
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
  })

  --Queen
  minetest.register_node("chess:queen_"..colors[color],
  {
    description = 'Queen ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8, 
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
  })

  --King
  minetest.register_node("chess:king_"..colors[color],
  {
    description = 'King ('..colors[color]..')',
    tiles = {"chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color].."_top.png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color]..".png", "chess_piece_"..colors[color].."_side.png", "chess_piece_"..colors[color].."_side.png"},
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "facedir",
    light_source = 8,
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
    groups = piece_group,
    can_dig = function(pos, placer)
      local player = placer:get_player_name()
      return is_owner(pos, player)
    end,
    after_place_node = function(pos, placer)
      local meta = minetest.env:get_meta(pos)
      local player = placer:get_player_name()
      meta:set_string("infotext", "[Chess] "..player)
      meta:set_string("owner", player)
    end,
    on_punch = function(pos, node, puncher)
      local meta = minetest.env:get_meta(pos)
      local owner = minetest.env:get_meta(pos):get_string("owner")
      local player = puncher:get_player_name()
      local p = {x=pos.x, y=pos.y, z=pos.z}
      local n = minetest.env:get_node(p)
      local plo
      if (owner == "") then
        local meta = minetest.env:get_meta(pos)
        meta:set_string("infotext", "[Chess] "..player)
        meta:set_string("owner", player)
        if ( n.name == "chess:king_white" ) then
          minetest.chat_send_all("[Chess] "..player .. " plays as WHITE")
          plo = {x=pos.x+3, y=pos.y, z=pos.z}
        else
          minetest.chat_send_all("[Chess] "..player .. " plays as BLACK")
          plo = {x=pos.x+3, y=pos.y, z=pos.z-1}
        end
        for i = 0, 7, 1 do
            
            local p = {x=plo.x-i, y=plo.y, z=plo.z+1}
            local meta = minetest.env:get_meta(p)
            meta:set_string("infotext", "[Chess] "..player)
            meta:set_string("owner", player)
            
            local pt = {x=plo.x-i, y=plo.y, z=plo.z}
            local meta = minetest.env:get_meta(pt)
            meta:set_string("infotext", "[Chess] "..player)
            meta:set_string("owner", player)
            
        end
      end
    end,
  })
end
