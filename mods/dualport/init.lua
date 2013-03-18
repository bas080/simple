local teleporters = {}

teleporters.file = minetest.get_worldpath()..'/teleporters'

if minetest.get_modpath("flolands") then
  minetest.register_craft({
    output = 'dualport:dualport',
    recipe = {
      {'flolands:floatsand','default:sand'},
      {'default:cactus','default:desert_sand'},
    }
  })
else
  minetest.register_craft({
    output = 'dualport:dualport',
    recipe = {
      {'default:glass','default:mese_crystal'},
      {'default:cactus','default:desert_sand'},
    }
  })
end

local function is_owner(pos, placer)
  local owner = minetest.env:get_meta(pos):get_string("owner")
  local player = placer:get_player_name()
  if owner == "" or owner == player then
    return true
  end
    return false
end

teleporters.reset = function()
  local save_contents = ""
  local f = io.open(teleporters.file, "w")
  f:write(save_contents)
  io.close(f)
end

teleporters.link = function(pos)
  local save_contents
  --print("check if file exists")
  local f = io.open(teleporters.file, "r")
  if f then
    --print("file exists")
    local contents = f:read()
    io.close(f)
    if contents == "" or contents == nil then
      --print("nothing to pair with saving coordinates")
      save_contents = tostring(pos.x..","..pos.y..","..pos.z)
      --print(save_contents)
    else
      --print("linking with uneven node")
      local p = {}
      p.x, p.y, p.z = string.match(contents, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
      if p.x and p.y and p.z then
        coordinates = {x = tonumber(p.x),y= tonumber(p.y),z = tonumber(p.z)}
        --get node names
        local meta = minetest.env:get_meta(coordinates)
        local name_two = meta:get_string("name")
        local meta = minetest.env:get_meta(pos)
        local name_one = meta:get_string("name")
        --set node infotext and link
        local meta = minetest.env:get_meta(coordinates)
        meta:set_string("link", pos.x..","..pos.y..","..pos.z)
        meta:set_string("infotext", name_two.." > "..name_one)
        --notify
        minetest.sound_play("dualport_linked",{pos=pos,gain=0.7,max_hear_distance=32})
        minetest.chat_send_all("Dualport linked to "..meta:get_string("infotext"))
        meta:set_string("infotext", meta:get_string("infotext"))
        
        local name = meta:get_string("name")
        local meta = minetest.env:get_meta(pos)
        meta:set_string("link", contents)
        meta:set_string("infotext", name_one.." > "..name_two)
        save_contents = ""
        
      else
        teleporters.reset()
      end
    end
    local f = io.open(teleporters.file, "w")
    f:write(save_contents)
    io.close(f)
  else
    --print("file does not exist")
    save_contents = tostring(pos.x..","..pos.y..","..pos.z)
    local f = io.open(teleporters.file, "w")
    f:write(save_contents)
    io.close(f)
  end
end

teleporters.formspec = function (meta)
  formspec = "size[6,3]" ..
  "label[2,0;Area]"..
  "field[1,1.25;4.5,1;desc;name;]"..
  "button_exit[2,2;2,1;save;Save]"
  return formspec
end

minetest.register_node("dualport:dualport", {
  description = "Dualport teleporter",
  tiles = {"teleporters_base.png"},
  groups = {cracky=3},
  light_source = 10,
  on_punch = function(pos)
  
    local meta = minetest.env:get_meta(pos)
    local link = meta:get_string("link")
    local newpos = {}
    newpos.x, newpos.y, newpos.z = string.match(link, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
    if newpos.x and newpos.y and newpos.z then
      pos.y = pos.y+.5
      local objs = minetest.env:get_objects_inside_radius(pos, .5)
      pos.y = pos.y -.5
      for _, obj in pairs(objs) do
        minetest.sound_play("dualport_teleport",{pos=newpos,gain=0.4,max_hear_distance=32})
        newpos.y = newpos.y -1
        teleporters.teleport({obj=obj,pos=newpos})
        newpos.y = newpos.y +1.7
        minetest.after(.1, teleporters.teleport, {obj=obj,pos=newpos})
      end
    end
  
  end,
  after_place_node = function(pos, placer)
    local meta = minetest.env:get_meta(pos)
    local player = placer:get_player_name()
    meta:set_string("infotext", "unnamed")
    meta:set_string("link", "")
    meta:set_string("name", "unnamed")
    meta:set_string("owner", player)
    meta:set_string("formspec",teleporters.formspec(meta))
    teleporters.link(pos)
  end,
  on_receive_fields = function(pos, formname, fields, sender)
    if fields.desc then
      
      local meta = minetest.env:get_meta(pos)
      local link = meta:get_string("link")
      local p = {}
      p.x, p.y, p.z = string.match(link, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
      
      local meta = minetest.env:get_meta(p)
      local name = meta:get_string("name")
      
      --print("link:"..link)
      
      if link == "" then
        meta = minetest.env:get_meta(pos)
        meta:set_string("name",fields.desc)
        meta:set_string("infotext", fields.desc)
      else
        meta:set_string("infotext", meta:get_string("name").." > "..fields.desc)
        name = meta:get_string("name")
        meta = minetest.env:get_meta(pos)
        meta:set_string("infotext", fields.desc.." > "..name)
        meta:set_string("name",fields.desc)
      end
    end
  end,
  can_dig = function(pos, placer)
    return is_owner(pos, placer)
  end,
  on_destruct = function(pos, node, digger)
    local meta = minetest.env:get_meta(pos)
    local link = meta:get_string("link")
    if link == "" then
      teleporters.reset()
    else
      local p = {}
      p.x, p.y, p.z = string.match(link, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
      local meta = minetest.env:get_meta(p)
      meta:set_string("link", "")
      meta:set_string("infotext", meta:get_string("name"))
    end
  end,
})

teleporters.teleport = function (params)
	params.obj:setpos(params.pos)
end

minetest.register_abm({
  nodenames = {"dualport:teleporter"},
  interval = 5,
  chance = 1,
  action = function(pos, node)
    
  end,
})


