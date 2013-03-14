[MOD] NonCubicBlocks 1.1 - for Minetest v0.4 or later
--------------------------------------by yves_de_beck



Install:
--------
Simply copy the complete "noncubic" folder in the ..minetest-0.4.4-win32/mods/minetest/ directory.



Dependence:
-----------
Default Stairs MOD (inkluding Minetest v0.4 or higher)



For Slower PC's:
----------------
You can change in the init.lua the 'detail_level = 20' lower (or higher for faster PC's)

Example: 'detail_level = 16' works very well for older PC's and looks good. =D



Recipes:
--------

Milling Machine Block:
----------------------
[cobble]	[stick]		[cobble]
[wood planks]	[wood planks]	[wood planks]
[stick]		[nothing]	[stick]

Craft NonCubics without Milling Machine:
----------------------------------------
(o=nothing) 
(x=regular stairblocklock wood/stone/sandstone/cobble/brick, 
 Leaves, Dirt or Glass)

Slope:
xoo   oox
xxo   oxx
xxx   xxx

Slope Upside Down:
xxx   xxx
oxx   xxo
oox   xoo

Slope Edge:
ooo   ooo
xoo   oox
xxo   oxx

Slope Inner Edge:
oox   xoo
xoo   oox
xxo   oxx

Slope Edge Upside Down:
oxx   xxo
oox   xoo
ooo   ooo

Slope Inner Edge Upside Down:
oxx   xxo
oox   xoo
xoo   oox

Pyramid:
ooo
oxo
xox

Spike:
oxo
xox
xox

Cylinder Vertical: 
xxo
xxo
xxo
(You can also craft one cylinder vertical 
 in a cylinder horizontal)

Cylinder Horizontal: 
ooo
xxx
xxx
(You can also craft one cylinder horizontal 
 in a cylinder vertical)

Sphere:
oxo
xox
oxo

Element Straight:
oxo
oxo
oxo

Element Edge:
xxx
oox
oox

Element T:
ooo
xxx
oxo

Element Cross:
oxo
xxx
oxo

Element End:
ooo
oxo
oxo

For double height Elements simply craft:
(o=nothing)
(x=element Straight, Edge, T, Cross or Element End)
ooo
xoo
xoo

Sticks: 
(o=nothing) 
(x=regular wood, stone, sandstone, cobble, brick, 
 leaves or glass) 
(y=regular wooden stick)
yoo
ooo
xoo