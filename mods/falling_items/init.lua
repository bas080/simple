--for instructions read readme

--check for attached item
local dx = {0, 0, 0, 0, 1, -1}
local dy = {0, 0, 1, -1, 0, 0}
local dz = {1, -1, 0, 0, 0, 0}

minetest.register_on_dignode(function (pos, node, player)
  
  --check for attached nodes
  for i = 1, 6 do
    local p = {x = pos.x + dx[i], y = pos.y + dy[i] , z = pos.z + dz[i]}
    local n = minetest.env:get_node(p)
    if minetest.get_item_group(n.name, "attached") ~= 0 then
      print("bam")
      connected = false
      for ii = 1, 6 do
        local ptwo = {x = p.x + dx[ii], y = p.y + dy[ii] , z = p.z + dz[ii]}
        local ntwo = minetest.env:get_node(ptwo)
        if minetest.registered_nodes[ntwo.name].walkable then
          connected = true
        end
      end
      if connected == false then
        drop_attached_node(p)
        minetest.env:dig_node(p)
      end
    end
  end
  
  --check for floored item
  local p = {x = pos.x, y = pos.y+1, z = pos.z}
  local n = minetest.env:get_node(p)
  if minetest.get_item_group(n.name, "floored") ~= 0 then
    drop_attached_node(p)
    minetest.env:dig_node(p)
  end
  
  local p = {x = pos.x, y = pos.y-1, z = pos.z}
  local n = minetest.env:get_node(p)
  if minetest.get_item_group(n.name, "hanging") ~= 0 then
    drop_attached_node(p)
    minetest.env:dig_node(p)
  end
  
end)

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
  --check if node has floor else fall
  if minetest.get_item_group(newnode.name, "hanging") ~= 0 then
    local p = {x = pos.x, y = pos.y+1, z = pos.z}
    local n = minetest.env:get_node(p)
    if minetest.registered_nodes[n.name].walkable ~= true then
      drop_attached_node(pos)
    end
  end
  
  if minetest.get_item_group(newnode.name, "floored") ~= 0 then
    local p = {x = pos.x, y = pos.y-1, z = pos.z}
    local n = minetest.env:get_node(p)
    if minetest.registered_nodes[n.name].walkable ~= true then
      drop_attached_node(pos)
    end
  end
end)

