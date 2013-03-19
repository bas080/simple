Minetest mod "Fences"
=======================
version: 0.2

License of source code and textures:
------------------------------------
Written 2013 by BlockMen

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.





--USING the mod--

This mod "overrides" the recipe for the default fence, so if you want craft a fance, it crafts THIS fence.

If you want replace already placed default fences open the "init.lua" (in this directory) and change
the first line to "local override_original = true". Then all placed default fences will be replaced with this fence.