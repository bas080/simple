-- minetest/creative/init.lua

local creative_inventory = {}
creative_inventory.creative_inventory_size = 0

-- Create detached creative inventory after loading all mods
minetest.after(0, function()
    local inv = minetest.create_detached_inventory("creative", {
        allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
            if minetest.setting_getbool("creative_mode") then
                return count
            else
                return 0
            end
        end,
        allow_put = function(inv, listname, index, stack, player)
            if minetest.setting_getbool("creative_mode") then
                return -1
            else
                return 0
            end
        end,
        allow_take = function(inv, listname, index, stack, player)
            if minetest.setting_getbool("creative_mode") then
                return -1
            else
                return 0
            end
        end,
        on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
        end,
        on_put = function(inv, listname, index, stack, player)
        end,
        on_take = function(inv, listname, index, stack, player)
            print(player:get_player_name().." takes item from creative inventory; listname="..dump(listname)..", index="..dump(index)..", stack="..dump(stack))
            if stack then
                print("stack:get_name()="..dump(stack:get_name())..", stack:get_count()="..dump(stack:get_count()))
            end
        end,
    })
    local creative_list = {}
    for name,def in pairs(minetest.registered_items) do
        if (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
                and def.description and def.description ~= "" then
            table.insert(creative_list, name)
        end
    end
    table.sort(creative_list)
    inv:set_size("main", #creative_list)
    for _,itemstring in ipairs(creative_list) do
        local stack = ItemStack(itemstring)
        -- Make a stack of the right number of items
        local stack2 = nil
        if stack:get_stack_max() == 1 then
            stack2 = ItemStack(stack:get_name())
        else
            -- Insert half full so that a taken stack can be put back
            stack2 = ItemStack(stack:get_name().." "..(999))
        end
        inv:add_item("main", stack2)
    end
    creative_inventory.creative_inventory_size = #creative_list
    print("creative inventory size: "..dump(creative_inventory.creative_inventory_size))
end)

creative_inventory.set_creative_formspec = function(player, start_i, pagenum)
    pagenum = math.floor(pagenum)
    local pagemax = math.floor((creative_inventory.creative_inventory_size-1) / (5*8) + 1)
    player:set_inventory_formspec("size[9,8.5]"..
            "list[current_player;main;0.5,0.3;8,2;]"..
            "list[detached:creative;main;0.5,3.3;8,5;"..tostring(start_i).."]"..
            "button[0.5,2.3;1,1;creative_prev;<]"..
            "button[1.5,2.3;1,1;creative_next;>]"..
            "label[2.5,2.4;"..tostring(pagenum).."/"..tostring(pagemax).."]"..
            "button[6.5,2.3;2,1;creative_clear;Clear]"..
            "button[4.5,2.3;2,1;creative_switchpalette;Palette]")
end

minetest.register_on_joinplayer(function(player)
    -- If in creative mode, modify player's inventory forms
    if not minetest.setting_getbool("creative_mode") then
        return
    end
    creative_inventory.set_creative_formspec(player, 0, 1)
end)
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if not minetest.setting_getbool("creative_mode") then
        return
    end
    -- Figure out current page from formspec
    local current_page = 0
    local formspec = player:get_inventory_formspec()
    local start_i = string.match(formspec, "list%[detached:creative;main;[%d.]+,[%d.]+;[%d.]+,[%d.]+;(%d+)%]")
    start_i = tonumber(start_i) or 0

    if fields.creative_prev then
        start_i = start_i - 8*5
    end
    if fields.creative_next then
        start_i = start_i + 8*5
    end
    if fields.creative_clear then
        local inv = minetest.get_inventory({type='player',name=player:get_player_name()})
        for i=1,32 do
            local stack = inv:get_stack("main", i)
            if stack ~= nil and not stack:is_empty() then
                inv:set_stack("main", i, nil)
            end
        end
    end
    if fields.creative_switchpalette then
        local inv = minetest.get_inventory({type='player',name=player:get_player_name()})
        local items = {}
        for i=1,8 do
            local stack = inv:get_stack("main", i)
            local switchstack =  inv:get_stack("main", (i+8))
            items[i] = {}
            items[i] = {name=switchstack:get_name(),count=switchstack:get_count()}
            items[i+8] = {name=stack:get_name(),count=stack:get_count()}
        end
        for i =1,16 do
            if items[i].name and items[i].count then
                inv:set_stack("main", (i), ItemStack(items[i].name.." "..items[i].count))
            else
                inv:set_stack("main", i, nil)    
            end
        end
    end
    if start_i < 0 then
        start_i = start_i + 8*5
    end
    if start_i >= creative_inventory.creative_inventory_size then
        start_i = start_i - 8*5
    end
        
    if start_i < 0 or start_i >= creative_inventory.creative_inventory_size then
        start_i = 0
    end

    creative_inventory.set_creative_formspec(player, start_i, start_i / (5*8) + 1)
end)