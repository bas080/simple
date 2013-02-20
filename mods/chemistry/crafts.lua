--default
chemistry:register_reaction({"default:water_source",
  {"chemistry:O", "chemistry:O"},
  {"chemistry:and"},
  {"chemistry:H", "chemistry:H"},
  {"chemistry:H", "chemistry:H"},
})

chemistry:register_reaction({"default:sand",
  {"chemistry:Si"},
  {"chemistry:O", "chemistry:O"},
})

chemistry:register_reaction({"default:stone_with_coal",
  {"chemistry:C", "chemistry:C"},
})

--moreores
chemistry:register_reaction({"moreores:gold_block",
  {"chemistry:Au", "chemistry:Au"},
})

chemistry:register_reaction({"moreores:silver_block",
  {"chemistry:Sg", "chemistry:Sg"},
})

chemistry:register_reaction({"moreores:copper_block",
  {"chemistry:Cu", "chemistry:Cu"},
})

chemistry:register_reaction({"moreores:tin_block",
  {"chemistry:Sn", "chemistry:Sn"},
})

chemistry:register_reaction({"default:stone_with_iron",
  {"chemistry:Fe", "chemistry:Fe"},
})

--diamonds
chemistry:register_reaction({"diamonds:block",
  {"chemistry:C", "chemistry:C", "chemistry:C"},
  {"chemistry:C", "chemistry:C", "chemistry:C"},
  {"chemistry:C", "chemistry:C", "chemistry:C"},
})
