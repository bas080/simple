-- CHESS MOD
-- ======================================
-- chess/ownership.lua
-- ======================================
-- Ownershio function this is used in init and pieces lua
--
-- Contents:
--
-- [function] ownership
-- ======================================

--Node ownership functions
local function is_owner(pos, name)
  local owner = minetest.env:get_meta(pos):get_string("owner")
  if owner == "" or owner == name then
    return true
  end
    return false
end
