---
--worldtime 1.00
--Copyright (C) 2012 Bad_Command
--
--This library is free software; you can redistribute it and/or
--modify it under the terms of the GNU Lesser General Public
--License as published by the Free Software Foundation; either
--version 2.1 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public
--License along with this library; if not, write to the Free Software
--Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
----

-- Configuration option:  world time save interval (default: save time every 10 seconds)
--  Increase this is the server frequently loses time
worldtime_save_time_interval=10
-- Configuration option:  world time save file name
worldtime_save_file_name="worldtime.dat"

-- Call this method to get the world time
function worldtime_get() 
	return worldtime
end


worldtime_last_file_io = -1
worldtime = 0.0

function worldtime_get_filename() 
	return minetest.get_worldpath(modname) .. "/" .. worldtime_save_file_name
end

function worldtime_read_time() 
	local file
	local err
	file,err = io.open( worldtime_get_filename(), "r" )
	if err then
		return false
	end
	local text = file:read("*all")
	local time = string.match(text, "^(%d+\.?%d*)$")
	if time == nil or string.match(time, "^%d+\.$") then	
		minetest.log("info", "worldtime: Could not parse text when reading worldtime: " .. text)
		return false
	end
	worldtime = time + 0.0
	worldtime_last_file_io = worldtime
	return true
end

function worldtime_write_time()
	local file
	local err
	file,err = io.open( worldtime_get_filename(), "w" )
	if err then 
		return false 
	end
	file:write(worldtime)
	file:close()
	worldtime_last_file_io = worldtime
	return true
end

function worldtime_timechange(dtime)
	local save_time = false
	if worldtime_last_file_io < 0 then
		if not worldtime_read_time() then
			minetest.log('error', 
				"WARNING: worldtime:  Could not read time from "..
					worldtime_get_filename() )
			save_time = true
		else 
			minetest.log('trace', 
				"worldtime:  Read current time ("..worldtime..") from "..
					worldtime_get_filename() )
		end
	end
	worldtime = worldtime + dtime
	if save_time or worldtime - worldtime_last_file_io > worldtime_save_time_interval then
		if not worldtime_write_time() then
			minetest.log('error', 
				"WARNING: worldtime:  Could not save time to "..
					worldtime_get_filename() )	
		else
			minetest.log('trace', 
				"worldtime:  Saved current time ("..worldtime..") to "..
					worldtime_get_filename() )
		end
	end
end

minetest.register_globalstep(worldtime_timechange)
