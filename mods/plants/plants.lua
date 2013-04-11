plants:register_plant({
  name = "lavender",
  surface = "default:dirt_with_grass",
  height_min = 1,
  height_max = 60,
  spread = 4,
  habitat_size = 4,
  habitat_nodes = {"default:sand"},
})

plants:register_plant({
  name = "corn",
  surface = "default:dirt_with_grass",
  height_min = 1,
  height_max = 60,
  spread = 8,
  habitat_size = 10,
  habitat_nodes = {"default:water_source"},
})

plants:register_plant({
  name = "cotton",
  surface = "default:dirt_with_grass",
  height_min = 1,
  height_max = 60,
  spread = 8,
  habitat_size = 10,
  habitat_nodes = {"default:desert_sand"},
})

plants:register_plant({
  name = "aloe",
  surface = "default:desert_sand",
  height_min = 5,
  height_max = 40,
  spread = 12,
  habitat_size = 20,
  habitat_nodes = {"default:water_source", "default:cactus", "default:dirt_with_grass"},
})

plants:register_plant({
  name = "tallgrass",
  surface = "default:dirt_with_grass",
  height_min = 1,
  height_max = 20,
  spread = 3,
  habitat_size = 20,
  habitat_nodes = {"default:water_source"},
})

plants:register_plant({
  name = "grass",
  surface = "default:dirt_with_grass",
  height_min = 2,
  height_max = 20,
  spread = 3,
  habitat_size = 40,
  habitat_nodes = {"default:water_source"},
})
