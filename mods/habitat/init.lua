--Habitat is a mod which adds the function to spawn nodes near certain nodes and away from others on map generate

--HOW TO USE
--minetest.register_on_generated(function(minp, maxp, seed)
    --generate("plants:lavender_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 4, 4, {"default:sand",})
--end)

local function arrayContains(array, value)
  for _,v in pairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

function generate(node, surfaces, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes, antitat_size, antitat_nodes)
  
  if height_min > maxp.y or height_max < minp.y then --stop if min and max height of plant spawning is not generated area
    return
  end

  local height_min_max = math.max(height_min,minp.y)
  local height_max_min = math.min(height_max,maxp.y)

  local width   = maxp.x-minp.x
  local length  = maxp.z-minp.z
  local height  = height_max-height_min

  local y_current
  local x_current
  local z_current

  local x_deviation
  local z_deviation

  local p = {x=minp.x, y=y_current, z=minp.z}
  local n = minetest.env:get_node(p).name
  local n_top
  local p_top
  
  local loops = 0
  --loop and take steps depending on the spread of the plants
  for x_current = spread/2, width, spread do
    for z_current = spread/2, length, spread do
      x_deviation = math.floor(math.random(spread))-spread/2
      z_deviation = math.floor(math.random(spread))-spread/2
      for y_current = height_max_min, height_min_max, -1 do --loop to look for the node that is not air
        n_top = n
        p = {x=minp.x+x_current+x_deviation, y=y_current, z=minp.z+z_current+z_deviation}
        n = minetest.env:get_node(p).name
        if n ~= "air" and n_top == "air" then
          if arrayContains(surfaces, n) then
            p_top = {x=p.x, y=p.y+1, z=p.z}
            if minetest.env:find_node_near(p_top, habitat_size, habitat_nodes) ~= nil and minetest.env:find_node_near(p_top, antitat_size, antitat_nodes) == nil  then
              minetest.env:add_node(p_top, {name=node})
            end
          end
        end
      end
    end
  end
end
print("[Habitat] Loaded!")
