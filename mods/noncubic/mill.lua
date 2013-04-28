material = {}
shape = {}
make_ok = {}
anzahl = {}

minetest.register_node("noncubic:mill", {
	description = "Milling Machine",
	tiles = {"cnc_top.png", "cnc_bottom.png", "cnc_side.png",
		"cnc_side.png", "cnc_side.png", "cnc_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
	type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},

			},
	},
	selection_box = {
	type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	groups = {oddly_breakable_by_hand=2, cracky=3, dig_immediate=1},

can_dig = function(pos,player)
	local meta = minetest.env:get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
	return true
end,

on_construct = function(pos)
	local meta = minetest.env:get_meta(pos)
	meta:set_string("formspec", "invsize[8,11;]"..
		"background[-0.15,-0.25;8.40,11.75;milling_background.png]"..
		"list[current_name;ingot;1,5.5;1,1;]"..
		"list[current_name;res;6,5.5;1,1;]"..
		"label[0,5.5;Input:]"..
		"label[4.5,5.5;Output:]"..
		"label[0,0;Choose Milling Program:]"..
		"image_button[0,0.5;1,1;slope.png;slope; ]"..
		"image_button[1,0.5;1,1;slope_edge.png;slope_edge; ]"..
		"image_button[2,0.5;1,1;slope_inner_edge.png;slope_inner_edge; ]"..
		"image_button[3,0.5;1,1;pyramid.png;pyramid; ]"..
		"image_button[4,0.5;1,1;spike.png;spike; ]"..
		"image_button[5,0.5;1,1;cylinder.png;cylinder; ]"..
		"image_button[6,0.5;1,1;sphere.png;sphere; ]"..
		"image_button[0,1.5;1,1;slope_upsdwn.png;slope_upsdwn; ]"..
		"image_button[1,1.5;1,1;slope_edge_upsdwn.png;slope_edge_upsdwn; ]"..
		"image_button[2,1.5;1,1;slope_inner_edge_upsdwn.png;slope_inner_edge_upsdwn; ]"..
		"image_button[5,1.5;1,1;cylinder_horizontal.png;cylinder_hor; ]"..
		"label[0,3;Slim Elements half height:]"..
		"image_button[0,3.5;1,1;element_straight.png;element_straight; ]"..
		"image_button[1,3.5;1,1;element_end.png;element_end; ]"..
		"image_button[2,3.5;1,1;element_cross.png;element_cross; ]"..
		"image_button[3,3.5;1,1;element_t.png;element_t; ]"..
		"image_button[4,3.5;1,1;element_edge.png;element_edge; ]"..
		"image_button[7,0.5;1,1;stick.png;stick; ]"..
		"list[current_player;main;0,7;8,4;]")
	meta:set_string("infotext", "Milling Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()

-- REGISTER MILLING PROGRAMMS
-----------------------------
if fields["slope"] or fields["slope_edge"] or fields["slope_inner_edge"] or fields["pyramid"] or fields["spike"] or fields["cylinder"] or fields["cylinder_hor"] or fields["sphere"] or fields["slope_upsdwn"] or fields["slope_edge_upsdwn"] or fields["slope_inner_edge_upsdwn"] or fields["element_straight"] or fields["element_end"] or fields["element_cross"] or fields["element_t"] or fields["element_edge"] or fields["stick"] then


	if fields["slope"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:slope_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["slope_edge"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:slope_edge_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["slope_inner_edge"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:slope_inner_edge_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["pyramid"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:pyramid_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["spike"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:spike_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["cylinder"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:cylinder_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["cylinder_hor"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:cylinder_horizontal_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["sphere"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:cylinder_sphere_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["slope_upsdwn"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:slope_upsdown_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["slope_edge_upsdwn"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:slope_upsdown_edge_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["slope_inner_edge_upsdwn"] then
		make_ok = "0"
		anzahl = "1"
		shape = "noncubic:slope_upsdown_inner_edge_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["element_straight"] then
		make_ok = "0"
		anzahl = "4"
		shape = "noncubic:element_straight_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["element_end"] then
		make_ok = "0"
		anzahl = "4"
		shape = "noncubic:element_end_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["element_cross"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:element_cross_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["element_t"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:element_t_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["element_edge"] then
		make_ok = "0"
		anzahl = "2"
		shape = "noncubic:element_edge_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["stick"] then
		make_ok = "0"
		anzahl = "8"
		shape = "noncubic:stick_"
		if inv:is_empty("ingot") then
			return
		end
	end

-----------------------------


		local ingotstack = inv:get_stack("ingot", 1)
		local resstack = inv:get_stack("res", 1)


-- Register Materials Milling Machine can make Shapes
-----------------------------------------------------
		if ingotstack:get_name()=="default:wood" then
				material = "wood"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:cobble" then
				material = "cobble"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:stone" then
				material = "stone"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:brick" then
				material = "brick"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:sandstone" then
				material = "sandstone"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:dirt" then
				material = "dirt"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:leaves" then
				material = "leaves"
				make_ok = "1"
		end
		if ingotstack:get_name()=="default:glass" then
				material = "glass"
				make_ok = "1"
		end
-----------------------------------------------------            


-- Milling
----------
		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res",shape .. material)
			end
			ingotstack:take_item()
			inv:set_stack("ingot",1,ingotstack)
		end            

	
end
end,
})
----------


-- Milling Machine Recipe
-------------------------
minetest.register_craft({
		output = 'noncubic:mill',
		recipe = {
			{'default:cobble', 'default:stick', 'default:cobble'},
			{'default:wood', 'default:wood', 'default:wood'},
			{'default:stick', "", 'default:stick'},		
		},
})
-------------------------
