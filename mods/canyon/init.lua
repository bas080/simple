-- canyon 0.1.0 by paramat
-- License WTFPL, see license.txt

-- Editable parameters.

local CANYON = true -- Enable / disable canyon (true / false).
local DEBUG = true

local SEEDDIFF1 = 5192 
local OCTAVES1 = 6 -- 6
local PERSISTENCE1 = 0.5 -- 0.5
local SCALE1 = 1024 -- 1024
local NOISEL = -0.02 -- -0.02
local NOISEH = 0.02 -- 0.02

local SEEDDIFF2 = 9247
local OCTAVES2 = 4 -- 4
local PERSISTENCE2 = 0.5 -- 0.5
local SCALE2 = 256 -- 256

-- Stuff. What this does i know not.

canyon = {}

-- On generated function.

if CANYON then
	minetest.register_on_generated(function(minp, maxp, seed)
		if DEBUG then
			print ("[canyon] Generate chunk ("..minp.x.." "..minp.y.." "..minp.z..")")
		end
		if minp.y == -32 then
			local env = minetest.env
			local perlin1 = env:get_perlin(SEEDDIFF1, OCTAVES1, PERSISTENCE1, SCALE1)
			local perlin2 = env:get_perlin(SEEDDIFF2, OCTAVES2, PERSISTENCE2, SCALE2)
			local nra = NOISEH - NOISEL
			local xl = maxp.x-minp.x
			local zl = maxp.z-minp.z
			local x0 = minp.x
			local z0 = minp.z
			if DEBUG then
				print ("[canyon] Processing chunk ("..minp.x.." "..minp.y.." "..minp.z..")")
			end
			-- Loop through columns in chunk.
			for i = 0, xl do
			for j = 0, zl do
				-- For each column do.
				local x = x0 + i
				local z = z0 + j
				local noise1 = perlin1:get2d({x=x,y=z})
				local noise2 = perlin2:get2d({x=x,y=z})
				local norm1 = (noise1 - NOISEL) * (NOISEH - noise1) / nra ^ 2 * 4
				local norm2 = (noise2 + 1.875) / 3.75
				if noise1 > NOISEL and noise1 < NOISEH then
					-- Find surface y.
					for y = maxp.y, minp.y, -1 do
						local nodename = env:get_node({x=x,y=y,z=z}).name
						if nodename ~= "air" then
							surfacey = y
							break
						end
					end
					-- Find seabed y.
					local seabedy = 47
					for y = minp.y, maxp.y do
						local nodename = env:get_node({x=x,y=y,z=z}).name
						if nodename == "default:water_source" then
							seabedy = y - 1
							break
						end
					end
					-- Calculate water rise and riverbed sand bottom y.
					local watris = math.ceil((surfacey - 1) / 11)
					local sanboty = math.floor((1 - norm1 * norm2) * 32) - 32 + watris
					-- Excavate canyon, add sand if below seabed and add water up to varying height.
					for y = sanboty, surfacey-1 do
						env:remove_node({x=x,y=y,z=z})
						if y <= sanboty + 2 and y <= seabedy then
							env:add_node({x=x,y=y,z=z}, {name="default:sand"})
						elseif y <= 1 then
							env:add_node({x=x,y=y,z=z}, {name="default:water_source"})
						elseif y <= watris + 1 then
							env:place_node({x=x,y=y,z=z}, {name="default:water_source"})
						end
					end
					-- Dig top node to reset lighting, place water there if at sea level.
					env:dig_node({x=x,y=surfacey,z=z})
					env:dig_node({x=x,y=surfacey,z=z})
					if surfacey == 1 then
						env:place_node({x=x,y=1,z=z}, {name="default:water_source"})
					end
				end
			end
			end
			if DEBUG then
				print ("[canyon] Completed")
			end
		end
	end)
end

