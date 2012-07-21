--Help-Functions
local round = function(num)
    return math.floor(num + 0.5)
end

local equals = function(num1, num2)
	if math.abs(num1-num2) < 0.3 then
		return true
	else
		return false
	end
end

local step_length = 0.00
local max_speed = 4.5--Speed of the cart

local cart = {
	physical = true,
	collisionbox = {-0.5, -0.5, -0.5,     0.5, 0.5, 0.5},
	visual = "cube",
	textures = {"carts_cart_top.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png"},
	--Variablen
	fahren = false,
	fallen = false,
	timer = 0,
	v = 0,
	dir = nil,
	vertikal = -10,
	items = {},
}

function cart:get_speed()
	if self.dir == "x+" then
		return self.object:getvelocity().x
	elseif self.dir == "x-" then
		return -1*self.object:getvelocity().x
	elseif self.dir == "z+" then
		return self.object:getvelocity().z
	elseif self.dir == "z-" then
		return -1*self.object:getvelocity().z
	end
	return 0
end

function cart:set_speed(speed)
	local newsp = {x=0, y=0, z=0}
	if self.dir == "x+" then
		newsp.x = speed
	elseif self.dir == "x-" then
		newsp.x = -1*speed
	elseif self.dir == "z+" then
		newsp.z = speed
	elseif self.dir == "z-" then
		newsp.z = -1*speed
	end
	self.object:setvelocity(newsp)
end

function cart:set_acceleration(staerke)
	if self.dir == "x+" then
		self.object:setacceleration({x=staerke, y=self.vertikal, z=0})
	elseif self.dir == "x-" then
		self.object:setacceleration({x=-staerke, y=self.vertikal, z=0})
	elseif self.dir == "z+" then
		self.object:setacceleration({x=0, y=self.vertikal, z=staerke})
	elseif self.dir == "z-" then
		self.object:setacceleration({x=0, y=self.vertikal, z=-staerke})
	end
end

function cart:stop()
	self.object:setacceleration({x = 0, y = self.vertikal, z = 0})
	self:set_speed(0)
	local pos = self.object:getpos()
	pos.x = round(pos.x)
	pos.y = round(pos.y)
	pos.z = round(pos.z)
	self.object:setpos(pos)
end

function cart:get_new_direction()
	local pos = self.object:getpos()
	if self.dir == nil then
		return nil
	end
	pos.x = round(pos.x)
	pos.y = round(pos.y)
	pos.z = round(pos.z)
	if self.fallen then
		if minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:rail" then
			return "y-"
		end
	end
	if self.dir == "x+" then
		pos.x = pos.x+1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x+"
		end
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y-"
		end
		pos.y = pos.y+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y+"
		end
		pos.y = pos.y-1
		
		pos.x = pos.x-1
		pos.z = pos.z-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z-"
		end
		pos.z = pos.z+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z+"
		end
		pos.z = pos.z-1
	elseif self.dir == "x-" then
		pos.x = pos.x-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x-"
		end
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y-"
		end
		pos.y = pos.y+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y+"
		end
		pos.y = pos.y-1
		
		pos.x = pos.x+1
		pos.z = pos.z+1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z+"
		end
		pos.z = pos.z-2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z-"
		end
		pos.z = pos.z+1
	elseif self.dir == "z+" then
		pos.z = pos.z+1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z+"
		end
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y-"
		end
		pos.y = pos.y+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y+"
		end
		pos.y = pos.y-1
		
		pos.z = pos.z-1
		pos.x = pos.x+1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x+"
		end
		pos.x = pos.x-2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x-"
		end
		pos.x = pos.x+1
	elseif self.dir == "z-" then
		pos.z = pos.z-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "z-"
		end
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y-"
		end
		pos.y = pos.y+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "y+"
		end
		pos.y = pos.y-1
		
		pos.z = pos.z+1
		pos.x = pos.x-1
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x-"
		end
		pos.x = pos.x+2
		if minetest.env:get_node(pos).name == "default:rail" then
			return "x+"
		end
		pos.x = pos.x-1
	end
	return nil
end

--Fahren
function cart:on_step(dtime)
	if self.timer < step_length then
		self.timer = self.timer+dtime
		return
	end
	self.timer = 0
	
	if not self.fahren then
		self.object:setacceleration({x=0, y=self.vertikal, z=0})
		return
	end
	
	local newdir = self:get_new_direction()
	--[[if newdir ~= nil then
		minetest.debug("[carts] Neue Richtung ist "..newdir)
	else
		minetest.debug("[carts] Cart muss anhalten")
	end]]
	if newdir == nil and not self.fallen then
		self.vertikal = -10
		self.fahren = false
		self.items = {}
		self:stop()
		return
	elseif newdir == "y+" then
		self.fallen = false
		self.vertikal = 30
	elseif newdir == "y-" then
		self.vertikal = -500
		self.fallen = true
	elseif newdir ~= self.dir then
		self.fallen = false
		self.vertikal = -10
		local pos = self.object:getpos()
		--Warten bis der Stein nahezu erreicht wird
		if not equals(pos.x, round(pos.x)) or not equals(pos.y, round(pos.y)) or not equals(pos.z, round(pos.z)) then
			return
		end
		pos.x = round(pos.x)
		pos.y = round(pos.y)
		pos.z = round(pos.z)
		local speed = self:get_speed()
		self.dir = newdir
		self:set_speed(speed)
		self.object:setpos(pos)
	else
		self.vertikal = -10
	end
	
	if self.fahren and self:get_speed() < max_speed then
		self:set_acceleration(10)
	else
		self:set_acceleration(0)
	end
	
	for i,item in ipairs(self.items) do
		item:setpos(self.object:getpos())
	end
end

--Zustand umkehren
function cart:on_rightclick(clicker)
	if self.fahren then
		self.fahren = false
		self.items = {}
		self:stop()
	else
		local pos_cart = self.object:getpos()
		local pos_player = clicker:getpos()
		local res = {x=pos_cart.x-pos_player.x, z=pos_cart.z-pos_player.z}
		if math.abs(res.x) > math.abs(res.z) then
			if res.x < 0 then
				self.dir = "x-"
			else
				self.dir = "x+"
			end
		else
			if res.z < 0 then
				self.dir = "z-"
			else
				self.dir = "z+"
			end
		end
		local tmp = minetest.env:get_objects_inside_radius(self.object:getpos(), 1)
		for i,item in ipairs(tmp) do
			if not item:is_player() and item:get_luaentity().name ~= "carts:cart" then
				table.insert(self.items, item)
			end
		end
		self.fahren = true
	end
end

--Entity entfernen und im Inventar einfügen
function cart:on_punch(hitter)
	self.object:remove()
	hitter:get_inventory():add_item("main", "carts:cart")
end

--Gravitation setzen
function cart:on_activate(staticdata)
	self.object:setacceleration({x = 0, y = self.vertikal, z = 0})
end

minetest.register_entity("carts:cart", cart)

--Inventaritem erstellen
minetest.register_craftitem("carts:cart", {
	image = minetest.inventorycube("carts_cart_top.png", "carts_cart_side.png", "carts_cart_side.png"),
	wield_image = "carts_cart_top.png",
	description = "Cart",
	--Beim platzieren durch entity ersetzen
	on_place = function(itemstack, placer, pointed)
		local pos = pointed.under
		if minetest.env:get_node(pos).name ~= "default:rail" then
			pos = pointed.above
		end
		pos = {x = round(pos.x), y = round(pos.y), z = round(pos.z)}
		minetest.env:add_entity(pos, "carts:cart")
		itemstack:take_item(1)
		return itemstack
	end
})

minetest.register_craft({
	output = '"carts:cart" 1',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
	}
})
