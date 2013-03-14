function spawn_tnt(pos, entname)
    minetest.sound_play("nuke_ignite", {pos = pos,gain = 1.0,max_hear_distance = 8,})
    return minetest.env:add_entity(pos, entname)
end

function activate_if_tnt(nname, np, tnt_np, tntr)
    if nname == "experimental:tnt" or nname == "nuke:iron_tnt" or nname == "nuke:mese_tnt" or nname == "nuke:hardcore_iron_tnt" or nname == "nuke:hardcore_mese_tnt" then
        local e = spawn_tnt(np, nname)
        e:setvelocity({x=(np.x - tnt_np.x)*3+(tntr / 4), y=(np.y - tnt_np.y)*3+(tntr / 3), z=(np.z - tnt_np.z)*3+(tntr / 4)})
    end
end

function do_tnt_physics(tnt_np,tntr)
    local objs = minetest.env:get_objects_inside_radius(tnt_np, tntr)
    for k, obj in pairs(objs) do
        local oname = obj:get_entity_name()
        local v = obj:getvelocity()
        local p = obj:getpos()
        if oname == "experimental:tnt" or oname == "nuke:iron_tnt" or oname == "nuke:mese_tnt" or oname == "nuke:hardcore_iron_tnt" or oname == "nuke:hardcore_mese_tnt" then
            obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 2) + v.x, y=(p.y - tnt_np.y) + tntr + v.y, z=(p.z - tnt_np.z) + (tntr / 2) + v.z})
        else
            if v ~= nil then
                obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 4) + v.x, y=(p.y - tnt_np.y) + (tntr / 2) + v.y, z=(p.z - tnt_np.z) + (tntr / 4) + v.z})
            else
                if obj:get_player_name() ~= nil then
                    obj:set_hp(obj:get_hp() - 1)
                end
            end
        end
    end
end

-- Iron TNT

minetest.register_craft({
	output = 'node "nuke:iron_tnt" 4',
	recipe = {
		{'','node "default:wood" 1',''},
		{'craft "default:steel_ingot" 1','craft "default:coal_lump" 1','craft "default:steel_ingot" 1'},
		{'','node "default:wood" 1',''}
	}
})
minetest.register_node("nuke:iron_tnt", {
	tile_images = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"},
	inventory_image = minetest.inventorycube("nuke_iron_tnt_top.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"),
	dug_item = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Iron TNT",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "nuke:iron_tnt" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "nuke:iron_tnt")
		nodeupdate(p)
	end
end)

local IRON_TNT_RANGE = 6
local IRON_TNT = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,
}

function IRON_TNT:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function IRON_TNT:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        do_tnt_physics(pos, IRON_TNT_RANGE)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        if minetest.env:get_node(pos).name == "default:water_source" or minetest.env:get_node(pos).name == "default:water_flowing" then
            -- Cancel the Explosion
            self.object:remove()
            return
        end
        for x=-IRON_TNT_RANGE,IRON_TNT_RANGE do
        for y=-IRON_TNT_RANGE,IRON_TNT_RANGE do
        for z=-IRON_TNT_RANGE,IRON_TNT_RANGE do
            if x*x+y*y+z*z <= IRON_TNT_RANGE * IRON_TNT_RANGE + IRON_TNT_RANGE then
                local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
                local n = minetest.env:get_node(np)
                if n.name ~= "air" then
                    minetest.env:remove_node(np)
                end
                activate_if_tnt(n.name, np, pos, IRON_TNT_RANGE)
            end
        end
        end
        end
		self.object:remove()
	end
end

function IRON_TNT:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:get_inventory():add_item("main", "nuke:iron_tnt")
	end
end

minetest.register_entity("nuke:iron_tnt", IRON_TNT)

-- Mese TNT

minetest.register_craft({
	output = 'node "nuke:mese_tnt" 4',
	recipe = {
		{'','node "default:wood" 1',''},
		{'node "default:mese" 1','craft "default:coal_lump" 1','node "default:mese" 1'},
		{'','node "default:wood" 1',''}
	}
})
minetest.register_node("nuke:mese_tnt", {
	tile_images = {"nuke_mese_tnt_top.png", "nuke_mese_tnt_bottom.png",
			"nuke_mese_tnt_side.png", "nuke_mese_tnt_side.png",
			"nuke_mese_tnt_side.png", "nuke_mese_tnt_side.png"},
	inventory_image = minetest.inventorycube("nuke_mese_tnt_top.png",
			"nuke_mese_tnt_side.png", "nuke_mese_tnt_side.png"),
	dug_item = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Mese TNT",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "nuke:mese_tnt" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "nuke:mese_tnt")
		nodeupdate(p)
	end
end)

local MESE_TNT_RANGE = 12
local MESE_TNT = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"nuke_mese_tnt_top.png", "nuke_mese_tnt_bottom.png",
			"nuke_mese_tnt_side.png", "nuke_mese_tnt_side.png",
			"nuke_mese_tnt_side.png", "nuke_mese_tnt_side.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,
}

function MESE_TNT:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function MESE_TNT:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        do_tnt_physics(pos, MESE_TNT_RANGE)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        if minetest.env:get_node(pos).name == "default:water_source" or minetest.env:get_node(pos).name == "default:water_flowing" then
            -- Cancel the Explosion
            self.object:remove()
            return
        end
        for x=-MESE_TNT_RANGE,MESE_TNT_RANGE do
        for y=-MESE_TNT_RANGE,MESE_TNT_RANGE do
        for z=-MESE_TNT_RANGE,MESE_TNT_RANGE do
            if x*x+y*y+z*z <= MESE_TNT_RANGE * MESE_TNT_RANGE + MESE_TNT_RANGE then
                local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
                local n = minetest.env:get_node(np)
                if n.name ~= "air" then
                    minetest.env:remove_node(np)
                end
                activate_if_tnt(n.name, np, pos, MESE_TNT_RANGE)
            end
        end
        end
        end
		self.object:remove()
	end
end

function MESE_TNT:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:get_inventory():add_item("main", "nuke:mese_tnt")
	end
end

minetest.register_entity("nuke:mese_tnt", MESE_TNT)

-- Hardcore Iron TNT

minetest.register_craft({
	output = 'node "nuke:hardcore_iron_tnt" 1',
	recipe = {
		{'','craft "default:coal_lump" 1',''},
		{'craft "default:coal_lump" 1','node "nuke:iron_tnt" 1','craft "default:coal_lump" 1'},
		{'','craft "default:coal_lump" 1',''}
	}
})
minetest.register_node("nuke:hardcore_iron_tnt", {
	tile_images = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_hardcore_iron_tnt_side.png", "nuke_hardcore_iron_tnt_side.png",
			"nuke_hardcore_iron_tnt_side.png", "nuke_hardcore_iron_tnt_side.png"},
	inventory_image = minetest.inventorycube("nuke_iron_tnt_top.png",
			"nuke_hardcore_iron_tnt_side.png", "nuke_hardcore_iron_tnt_side.png"),
	dug_item = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Hardcore Iron TNT",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "nuke:hardcore_iron_tnt" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "nuke:hardcore_iron_tnt")
		nodeupdate(p)
	end
end)

local HARDCORE_IRON_TNT_RANGE = 6
local HARDCORE_IRON_TNT = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_hardcore_iron_tnt_side.png", "nuke_hardcore_iron_tnt_side.png",
			"nuke_hardcore_iron_tnt_side.png", "nuke_hardcore_iron_tnt_side.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,
}

function HARDCORE_IRON_TNT:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function HARDCORE_IRON_TNT:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        for x=-HARDCORE_IRON_TNT_RANGE,HARDCORE_IRON_TNT_RANGE do
        for z=-HARDCORE_IRON_TNT_RANGE,HARDCORE_IRON_TNT_RANGE do
            if x*x+z*z <= HARDCORE_IRON_TNT_RANGE * HARDCORE_IRON_TNT_RANGE + HARDCORE_IRON_TNT_RANGE then
                local np={x=pos.x+x,y=pos.y,z=pos.z+z}
                minetest.env:add_entity(np, "nuke:iron_tnt")
            end
        end
        end
		self.object:remove()
	end
end

function HARDCORE_IRON_TNT:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:add_to_inventory("node nuke:hardcore_iron_tnt 1")
		hitter:set_hp(hitter:get_hp() - 1)
	end
end

minetest.register_entity("nuke:hardcore_iron_tnt", HARDCORE_IRON_TNT)

-- Hardcore Mese TNT

minetest.register_craft({
	output = 'node "nuke:hardcore_mese_tnt" 1',
	recipe = {
		{'','craft "default:coal_lump" 1',''},
		{'craft "default:coal_lump" 1','node "nuke:mese_tnt" 1','craft "default:coal_lump" 1'},
		{'','craft "default:coal_lump" 1',''}
	}
})
minetest.register_node("nuke:hardcore_mese_tnt", {
	tile_images = {"nuke_mese_tnt_top.png", "nuke_mese_tnt_bottom.png",
			"nuke_hardcore_mese_tnt_side.png", "nuke_hardcore_mese_tnt_side.png",
			"nuke_hardcore_mese_tnt_side.png", "nuke_hardcore_mese_tnt_side.png"},
	inventory_image = minetest.inventorycube("nuke_mese_tnt_top.png",
			"nuke_hardcore_mese_tnt_side.png", "nuke_hardcore_mese_tnt_side.png"),
	dug_item = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Hardcore Mese TNT",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "nuke:hardcore_mese_tnt" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "nuke:hardcore_mese_tnt")
		nodeupdate(p)
	end
end)

local HARDCORE_MESE_TNT_RANGE = 6
local HARDCORE_MESE_TNT = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"nuke_mese_tnt_top.png", "nuke_mese_tnt_bottom.png",
			"nuke_hardcore_mese_tnt_side.png", "nuke_hardcore_mese_tnt_side.png",
			"nuke_hardcore_mese_tnt_side.png", "nuke_hardcore_mese_tnt_side.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,
}

function HARDCORE_MESE_TNT:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function HARDCORE_MESE_TNT:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        for x=-HARDCORE_MESE_TNT_RANGE,HARDCORE_MESE_TNT_RANGE do
        for z=-HARDCORE_MESE_TNT_RANGE,HARDCORE_MESE_TNT_RANGE do
            if x*x+z*z <= HARDCORE_MESE_TNT_RANGE * HARDCORE_MESE_TNT_RANGE + HARDCORE_MESE_TNT_RANGE then
                local np={x=pos.x+x,y=pos.y,z=pos.z+z}
                minetest.env:add_entity(np, "nuke:mese_tnt")
            end
        end
        end
		self.object:remove()
	end
end

function HARDCORE_MESE_TNT:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:add_to_inventory("node nuke:hardcore_mese_tnt 1")
		hitter:set_hp(hitter:get_hp() - 1)
	end
end

minetest.register_entity("nuke:hardcore_mese_tnt", HARDCORE_MESE_TNT)
