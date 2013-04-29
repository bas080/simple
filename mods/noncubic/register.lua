--Stairs
noncubic.register_stair_and_slab_and_panel_and_micro("noncubic", "grass", "default:dirt",
{crumbly=3},
{"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
"Grass Stairs",
"Grass Slab",
"Grass Panel",
"Grass Microblock",
"grass")

--Noncubic

noncubic.register_stick("noncubic", "wood","default:wood",
{snappy=2,choppy=2,oddly_breakable_by_hand=2},
{"default_wood.png"},
"Wooden")

noncubic.register_stick("noncubic", "stone","default:stone",
{cracky=3},
{"default_stone.png"},
"Stone")

noncubic.register_stick("noncubic", "cobble","default:cobble",
{cracky=3},
{"default_cobble.png"},
"Cobble")

noncubic.register_stick("noncubic", "brick","default:brick",
{cracky=3},
{"default_brick.png"},
"Brick")

noncubic.register_stick("noncubic", "sandstone","default:sandstone",
{crumbly=2,cracky=2},
{"default_sandstone.png"},
"Sandstone")

noncubic.register_elements("noncubic", "leaves","default:leaves",
{snappy=2,choppy=2,oddly_breakable_by_hand=3},
{"default_leaves.png"},
"Leaves")

noncubic.register_all("noncubic", "wood","default:wood",
{snappy=2,choppy=2,oddly_breakable_by_hand=2},
{"default_wood.png"},
"Wooden")

noncubic.register_all("noncubic", "junglewood","default:junglewood",
{snappy=2,choppy=2,oddly_breakable_by_hand=2},
{"default_junglewood.png"},
"Jungle Wooden")

noncubic.register_all("noncubic", "stone","default:stone",
{cracky=3},
{"default_stone.png"},
"StoneSlope",
"Stone")

noncubic.register_all("noncubic", "cobble","default:cobble",
{cracky=3},
{"default_cobble.png"},
"Cobble")

noncubic.register_all("noncubic", "brick","default:brick",
{cracky=3},
{"default_brick.png"},
"Brick")

noncubic.register_all("noncubic", "sandstone","default:sandstone",
{crumbly=2,cracky=2},
{"default_sandstone.png"},
"Sandstone")

noncubic.register_all("noncubic", "steel","default:steelblock",
{cracky=1,level=2},
{"default_steel_block.png"},
"Steel")

noncubic.register_all("noncubic", "tree","default:tree",
{tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
{"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
"Tree")
