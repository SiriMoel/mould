dofile_once("mods/mould/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
local radius = 15
local player = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )[1]
local shardcount = tonumber(GlobalsGetValue("shardcount"))

if player ~= nil then
    shardcount = shardcount + 1
    GlobalsSetValue("shardcount", tostring(shardcount))
    EntityKill(entity)
    GameAddFlagRun("mould_noshards")
end