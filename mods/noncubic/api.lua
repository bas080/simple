--API functions
---------------
--Single nodes
--------------
--noncubic.register_slope(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope_upsdown(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope_edge(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope_inner_edge(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope_upsdown_edge = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope_upsdown_inner_edge(modname, subname, recipeitem, groups, images,
--noncubic.register_pyramid(modname, subname, recipeitem, groups, images, description)
--noncubic.register_spike(modname, subname, recipeitem, groups, images, description)
--noncubic.register_cylinder = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_slope = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_sphere = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_element_straight = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_element_t = function(modname, subname, recipeitem, groups, images, description)
--noncubic.register_element_cross(modname, subname, recipeitem, groups, images, description)
--noncubic.register_element_end(modname, subname, recipeitem, groups, images, description)
--noncubic.register_element_straight_double(subname, recipeitem3, groups3, images3,
--noncubic.register_element_edge_double(subname, recipeitem3, groups3, images3, description3)
--noncubic.register_element_t_double(subname, recipeitem3, groups3, images3, description3)
--noncubic.register_element_cross_double(subname, recipeitem3, groups3, images3, description3)
--noncubic.register_element_end_double(subname, recipeitem3, groups3, images3, description3)
--noncubic.register_stick(subname, recipeitem2, groups2, images2, description2)

--Group nodes
-------------
--noncubic.register_all(modname, subname, recipeitem, groups, images, description)
--noncubic.register_spherical(modname, subname, recipeitem, groups, images , description)
--noncubic.register_slopes(modname, subname, recipeitem, groups, images , description)
--noncubic.register_roof(modname, subname, recipeitem, groups, images , description)
--noncubic.register_elements(modname, subname, recipeitem, groups, images , description)
--noncubic.register_stairs(modname, item, recipeitem, groups, images, description)

--Single
--------
noncubic.register_slope = function(modname, subname, recipeitem, groups, images, description)
  local slopebox = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopebox[i+1]={-0.5, (i/detail)-0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_" .. subname, {
    description = description.. " Slope",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopebox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_' .. subname .. ' 6',
    recipe = {
      {recipeitem, "", ""},
      {recipeitem, recipeitem, ""},
      {recipeitem, recipeitem, recipeitem},    
    },
  })
  minetest.register_craft({
    output = modname..':slope_' .. subname .. ' 6',
    recipe = {
      {"", "", recipeitem},
      {"", recipeitem, recipeitem},
      {recipeitem, recipeitem, recipeitem},    
    },
  })
end

noncubic.register_slope_upsdown = function(modname, subname, recipeitem, groups, images, description)
  local slopeupdwnbox = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopeupdwnbox[i+1]={-0.5, (i/detail)-0.5, (-1*(i/detail))+0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_upsdown_" .. subname, {
    description = description.. " Upside Down Slope",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopeupdwnbox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_' .. subname .. ' 6',
    recipe = {
      {recipeitem, recipeitem, recipeitem},
      {"", recipeitem, recipeitem},  
      {"", "", recipeitem},  
    },
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_' .. subname .. ' 6',
    recipe = {
      {recipeitem, recipeitem, recipeitem},
      {recipeitem, recipeitem, ""},  
      {recipeitem, "", ""},  
    },
  })
end

noncubic.register_slope_edge = function(modname, subname, recipeitem, groups, images, description)
  local slopeboxedge = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopeboxedge[i+1]={(i/detail)-0.5, -0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_edge_" .. subname, {
    description = description.. " Slope Edge",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopeboxedge,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_edge_' .. subname .. ' 3',
    recipe = {
      {"", "", ""},
      {recipeitem, "", ""},
      {recipeitem, recipeitem, ""},    
    },
  })
  minetest.register_craft({
    output = modname..':slope_edge_' .. subname .. ' 3',
    recipe = {
      {"", "", ""},
      {"", "", recipeitem},
      {"", recipeitem, recipeitem},    
    },
  })
end

noncubic.register_slope_inner_edge = function(modname, subname, recipeitem, groups, images, description)
  local slopeboxedge = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopeboxedge[i+1]={(i/detail)-0.5, -0.5, -0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
    slopeboxedge[i+detail+1]={-0.5, -0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_inner_edge_" .. subname, {
    description = description.. " Slope Inner Edge",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopeboxedge,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_inner_edge_' .. subname .. ' 3',
    recipe = {
      {"", "", recipeitem},
      {recipeitem, "", ""},
      {recipeitem, recipeitem, ""},    
    },
  })
  minetest.register_craft({
    output = modname..':slope_inner_edge_' .. subname .. ' 3',
    recipe = {
      {recipeitem, "", ""},
      {"", "", recipeitem},
      {"", recipeitem, recipeitem},    
    },
  })
end

noncubic.register_slope_upsdown_edge = function(modname, subname, recipeitem, groups, images, description)

  local slopeupdwnboxedge = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopeupdwnboxedge[i+1]={(-1*(i/detail))+0.5, (i/detail)-0.5, (-1*(i/detail))+0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_upsdown_edge_" .. subname, {
    description = description.. " Upside Down Slope Edge",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopeupdwnboxedge,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_edge_' .. subname .. ' 3',
    recipe = {
      {"", recipeitem, recipeitem},
      {"", "", recipeitem},
      {"", "", ""},
    },
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_edge_' .. subname .. ' 3',
    recipe = {
      {recipeitem, recipeitem, ""},
      {recipeitem, "", ""},
      {"", "", ""},
    },
  })

end

noncubic.register_slope_upsdown_inner_edge = function(modname, subname, recipeitem, groups, images, description)
  local slopeboxedge = {}
  local detail = detail_level
  for i = 0, detail-1 do
    slopeboxedge[i+1]={0.5-(i/detail)-(1/detail), (i/detail)-0.5, -0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
    slopeboxedge[i+detail+1]={-0.5, (i/detail)-0.5, 0.5-(i/detail)-(1/detail), 0.5, (i/detail)-0.5+(1/detail), 0.5}
  end
  minetest.register_node(modname..":slope_upsdown_inner_edge_" .. subname, {
    description = description.. " Upside Down Inner Slope Edge",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = slopeboxedge,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_inner_edge_' .. subname .. ' 3',
    recipe = {
      {"", recipeitem, recipeitem},
      {"", "", recipeitem},
      {recipeitem, "", ""},    
    },
  })
  minetest.register_craft({
    output = modname..':slope_upsdown_inner_edge_' .. subname .. ' 3',
    recipe = {
      {recipeitem, recipeitem, ""},
      {recipeitem, "", ""},
      {"", "", recipeitem},    
    },
  })
end

noncubic.register_pyramid = function(modname, subname, recipeitem, groups, images, description)
  local pyrabox = {}
  local detail = detail_level/2
  for i = 0, detail-1 do
    pyrabox[i+1]={(i/detail/2)-0.5, (i/detail/2)-0.5, (i/detail/2)-0.5, 0.5-(i/detail/2), (i/detail/2)-0.5+(1/detail), 0.5-(i/detail/2)}
  end
  minetest.register_node(modname..":pyramid_" .. subname, {
    description = description.. " Pyramid",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = pyrabox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':pyramid_' .. subname .. ' 3',
    recipe = {
      {"", "", ""},
      {"", recipeitem, ""},
      {recipeitem, "", recipeitem},    
    },
  })
end

noncubic.register_spike = function(modname, subname, recipeitem, groups, images, description)
  local spikebox = {}
  local detail = detail_level
  for i = 0, detail-1 do
    spikebox[i+1]={(i/detail/2)-0.5, (i/detail/2)-0.5, (i/detail/2)-0.5, 0.5-(i/detail/2), (i/detail)-0.5+(1/detail), 0.5-(i/detail/2)}
  end
  minetest.register_node(modname..":spike_" .. subname, {
    description = description.. " Spike",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = spikebox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':spike_' .. subname .. ' 5',
    recipe = {
      {"", recipeitem, ""},
      {recipeitem, "", recipeitem},
      {recipeitem, "", recipeitem},    
    },
  })
end

noncubic.register_cylinder = function(modname, subname, recipeitem, groups, images, description)
  local cylbox = {}
  local detail = detail_level
  local sehne
  for i = 1, detail-1 do
    sehne = math.sqrt(0.25 - (((i/detail)-0.5)^2))
    cylbox[i]={(i/detail)-0.5, -0.5, -sehne, (i/detail)+(1/detail)-0.5, 0.5, sehne}
  end
  minetest.register_node(modname..":cylinder_" .. subname, {
    description = description.. " Cylinder",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = cylbox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':cylinder_' .. subname .. ' 6',
    recipe = {
      {recipeitem, recipeitem, ""},
      {recipeitem, recipeitem, ""},
      {recipeitem, recipeitem, ""},    
    },
  })
  minetest.register_craft({
    output = modname..':cylinder_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':cylinder_horizontal_' .. subname, ""},
      {"", "", ""},    
    },
  })
end

noncubic.register_cylinder_horizontal = function(modname, subname, recipeitem, groups, images, description)
  local cylbox_horizontal = {}
  local detail = detail_level
  local sehne
  for i = 1, detail-1 do
    sehne = math.sqrt(0.25 - (((i/detail)-0.5)^2))
    cylbox_horizontal[i]={-0.5, (i/detail)-0.5, -sehne, 0.5, (i/detail)+(1/detail)-0.5, sehne}
  end
  minetest.register_node(modname..":cylinder_horizontal_" .. subname, {
    description = description.. " Horizontal Cylinder",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = cylbox_horizontal,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':cylinder_horizontal_' .. subname .. ' 6',
    recipe = {
      {"", "", ""},
      {recipeitem, recipeitem, recipeitem},
      {recipeitem, recipeitem, recipeitem},    
    },
  })
  minetest.register_craft({
    output = modname..':cylinder_horizontal_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':cylinder_' .. subname, ""},
      {"", "", ""},    
    },
  })
end

noncubic.register_sphere = function(modname, subname, recipeitem, groups, images, description)
  local spherebox = {}
  local detail = detail_level
  local sehne
  for i = 1, detail-1 do
    sehne = math.sqrt(0.25 - (((i/detail)-0.5)^2))
    spherebox[i]={-sehne, (i/detail)-0.5, -sehne, sehne, (i/detail)+(1/detail)-0.5, sehne}
  end
  minetest.register_node(modname..":cylinder_sphere_" .. subname, {
    description = description.. " Cylinder Sphere",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = spherebox,
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':cylinder_sphere_' .. subname .. ' 4',
    recipe = {
      {"", recipeitem, ""},
      {recipeitem, "", recipeitem},
      {"", recipeitem, ""},    
    },
  })
end

noncubic.register_element_straight = function(modname, subname, recipeitem, groups, images, description)
  minetest.register_node(modname..":element_straight_" .. subname, {
    description = description.. " Straight",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.5, 0.3, 0, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0, 0.5},
        },
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':element_straight_' .. subname .. ' 12',
    recipe = {
      {"", recipeitem, ""},
      {"", recipeitem, ""},
      {"", recipeitem, ""},    
    },
  })
end

noncubic.register_element_edge = function(modname, subname, recipeitem, groups, images, description)
  minetest.register_node(modname..":element_edge_" .. subname, {
    description = description.. " Edge",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        },
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':element_edge_' .. subname .. ' 10',
    recipe = {
      {recipeitem, recipeitem, recipeitem},
      {"", "", recipeitem},
      {"", "", recipeitem},    
      },
  })
end

noncubic.register_element_t = function(modname, subname, recipeitem, groups, images, description)
  minetest.register_node(modname..":element_t_" .. subname, {
    description = description.. " T Junction",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        {0.3, -0.5, -0.3, 0.5, 0, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        {0.3, -0.5, -0.3, 0.5, 0, 0.3},
        },
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':element_t_' .. subname .. ' 8',
    recipe = {
      {"", "", ""},
      {recipeitem, recipeitem, recipeitem},
      {"", recipeitem, ""},    
      },
  })
end

noncubic.register_element_cross = function(modname, subname, recipeitem, groups, images, description)
  minetest.register_node(modname..":element_cross_" .. subname, {
    description = description.. " Cross Junction",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {0.3, -0.5, -0.3, 0.5, 0, 0.3},
        {-0.3, -0.5, -0.5, 0.3, 0, 0.5},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {0.3, -0.5, -0.3, 0.5, 0, 0.3},
        {-0.3, -0.5, -0.5, 0.3, 0, 0.5},
        {-0.5, -0.5, -0.3, -0.3, 0, 0.3},
        },
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':element_cross_' .. subname .. ' 10',
    recipe = {
      {"", recipeitem, ""},
      {recipeitem, recipeitem, recipeitem},
      {"", recipeitem, ""},    
      },
  })
end

noncubic.register_element_end = function(modname, subname, recipeitem, groups, images, description)

  minetest.register_node(modname..":element_end_" .. subname, {
    description = description.. " End",
    drawtype = "nodebox",
    tiles = images,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.5},
    },
    groups = groups,
  })
  minetest.register_craft({
    output = modname..':element_end_' .. subname .. ' 8',
    recipe = {
      {"", "", ""},
      {"", recipeitem, ""},
      {"", recipeitem, ""},    
      },
  })

end

noncubic.register_element_straight_double = function(modname, subname, recipeitem3, groups3, images3, description3)
  minetest.register_node(modname..":element_straight_double_" .. subname, {
    description = description3.. " Straight Double",
    drawtype = "nodebox",
    tiles = images3,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
        },
    },
    groups = groups3,
  })
  minetest.register_craft({
    output = modname..':element_straight_double_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':element_straight_' .. recipeitem3, ""},
      {"", modname..':element_straight_' .. recipeitem3, ""},    
    },
  })

end

noncubic.register_element_edge_double = function (modname, subname, recipeitem3, groups3, images3, description3)

  minetest.register_node(modname..":element_edge_double_" .. subname, {
    description = description3.. " Edge Double",
    drawtype = "nodebox",
    tiles = images3,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        },
    },
    groups = groups3,
  })
  minetest.register_craft({
    output = modname..':element_edge_double_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':element_edge_' .. recipeitem3, ""},
      {"", modname..':element_edge_' .. recipeitem3, ""},    
    },
  })

end

noncubic.register_element_t_double = function (modname, subname, recipeitem3, groups3, images3, description3)

  minetest.register_node(modname..":element_element_t_double_" .. subname, {
    description = description3.. " T Double",
    drawtype = "nodebox",
    tiles = images3,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        {0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        {0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
        },
    },
    groups = groups3,
  })
  minetest.register_craft({
    output = modname..':element_element_t_double_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':element_t_' .. recipeitem3, ""},
      {"", modname..':element_t_' .. recipeitem3, ""},    
    },
  })

end

noncubic.register_element_cross_double = function (modname, subname, recipeitem3, groups3, images3, description3)
  minetest.register_node(modname..":element_cross_double_" .. subname, {
    description = description3.. " Cross Double",
    drawtype = "nodebox",
    tiles = images3,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {
        {0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        },
    },
    node_box = {
      type = "fixed",
      fixed = {
        {0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
        {-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
        {-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
        },
    },
    groups = groups3,
  })
  minetest.register_craft({
    output = modname..':element_cross_double_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':element_cross_' .. recipeitem3, ""},
      {"", modname..':element_cross_' .. recipeitem3, ""},    
      },
  })

end

noncubic.register_element_end_double = function (modname, subname, recipeitem3, groups3, images3, description3)
  minetest.register_node(modname..":element_end_double_" .. subname, {
    description = description3.. " End Double",
    drawtype = "nodebox",
    tiles = images3,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.5},
    },
    node_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.5},
    },
    groups = groups3,
  })
  minetest.register_craft({
    output = modname..':element_end_double_' .. subname .. ' 1',
    recipe = {
      {"", "", ""},
      {"", modname..':element_end_' .. recipeitem3, ""},
      {"", modname..':element_end_' .. recipeitem3, ""},
      },
  })
end

noncubic.register_stick = function (modname, subname, recipeitem2, groups2, images2, description2)
  minetest.register_node(modname..":stick_" .. subname, {
    description = description2.. " Stick",
    drawtype = "nodebox",
    tiles = images2,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.15, -0.5, -0.15, 0.15, 0.5, 0.15},
    },
    node_box = {
      type = "fixed",
      fixed = {-0.15, -0.5, -0.15, 0.15, 0.5, 0.15},
    },
    groups = groups2,
  })
  minetest.register_craft({
    output = modname..':stick_' .. subname .. ' 8',
    recipe = {
      {'default:stick', "", ""},
      {"", "", ""},
      {recipeitem2, "", ""},    
    },
  })
end

noncubic.register_stairs = function(modname, item, recipeitem, groups, images, description)
  local recipeitem = modname..":"..item
  local itemname = modname..":stair_"..item
	minetest.register_node(itemname, {
		description = description.." stair",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	})

	minetest.register_craft({
		output = itemname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = itemname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})

  itemname=modname..":slab_" .. item

	minetest.register_node(itemname, {
		description = description.." slab",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.env:get_node(p0)
			local n1 = minetest.env:get_node(p1)
			if n0.name == itemname then
				slabpos = p0
				slabnode = n0
			elseif n1.name == itemname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})

	minetest.register_craft({
		output = itemname .. ' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

--groups
--------
noncubic.register_roof = function(modname, subname, recipeitem, groups, images , description)
  noncubic.register_slope_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_inner_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope(modname, subname, recipeitem, groups, images, description)
  noncubic.register_pyramid(modname, subname, recipeitem, groups, images, description)
end

noncubic.register_slopes = function(modname, subname, recipeitem, groups, images , description)
  noncubic.register_slope(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_upsdown(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_inner_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_upsdown_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_slope_upsdown_inner_edge(modname, subname, recipeitem, groups, images, description)
  noncubic.register_pyramid(modname, subname, recipeitem, groups, images, description)
  noncubic.register_spike(modname, subname, recipeitem, groups, images, description)
end

noncubic.register_spherical = function(modname, subname, recipeitem, groups, images , description)
  noncubic.register_cylinder(modname, subname, recipeitem, groups, images, description)
  noncubic.register_cylinder_horizontal(modname, subname, recipeitem, groups, images, description)
  noncubic.register_sphere(modname, subname, recipeitem, groups, images, description)
end

noncubic.register_elements = function(modname, subname, recipeitem3, groups3, images3, description)
  noncubic.register_element_straight_double(modname, subname, recipeitem3, groups3, images3, description)
  noncubic.register_element_edge_double(modname, subname, recipeitem3, groups3, images3, description)
  noncubic.register_element_t_double(modname, subname, recipeitem3, groups3, images3, description)
  noncubic.register_element_cross_double(modname, subname, recipeitem3, groups3, images3, description)
  noncubic.register_element_end_double(modname, subname, recipeitem3, groups3, images3, description)
end

noncubic.register_all = function(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope_upsdown(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope_edge(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope_inner_edge(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope_upsdown_edge(modname, subname, recipeitem, groups, images, description)
   noncubic.register_slope_upsdown_inner_edge(modname, subname, recipeitem, groups, images, description)
   noncubic.register_pyramid(modname, subname, recipeitem, groups, images, description)
   noncubic.register_spike(modname, subname, recipeitem, groups, images, description)
   noncubic.register_cylinder(modname, subname, recipeitem, groups, images, description)
   noncubic.register_cylinder_horizontal(modname, subname, recipeitem, groups, images, description)
   noncubic.register_sphere(modname, subname, recipeitem, groups, images, description)
   noncubic.register_element_straight(modname, subname, recipeitem, groups, images, description)
   noncubic.register_element_edge(modname, subname, recipeitem, groups, images, description)
   noncubic.register_element_t(modname, subname, recipeitem, groups, images, description)
   noncubic.register_element_cross(modname, subname, recipeitem, groups, images, description)
   noncubic.register_element_end(modname, subname, recipeitem, groups, images, description)
end
