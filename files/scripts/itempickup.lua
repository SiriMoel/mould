dofile_once("mods/mould/files/scripts/inventory.lua")

local item = GetUpdatedEntityID()
local x, y = EntityGetTransform(item)
local player = EntityGetInRadiusWithTag( x, y, 5, "player_unit" )

if player ~= nil then
    local itemid = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( item, "VariableStorageComponent", "itemid" ), "value_string" )
    Inv.give( itemid )
end