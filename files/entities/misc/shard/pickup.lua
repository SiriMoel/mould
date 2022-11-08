dofile_once("mods/mould/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
local radius = 15
local player = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )[1]
local comp = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "shard_id" )
local id = ComponentGetValue2( comp, "value_int" )

if player ~= nil then
    for i,v in ipairs(shards_list) do
        if v["id"] == id then
            v["collected"] = true
        end
    end
    EntityKill(entity)
end