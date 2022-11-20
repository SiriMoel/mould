dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

local entity = GetUpdateEntityID()
local player = EntityGetWithTag("player_unit")[1]
local x, y = EntityGetTransform(player)

EntitySetTransform(entity, x, y)