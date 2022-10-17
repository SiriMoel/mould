dofile_once("mods/mould/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
local player = EntityGetWithTag("player_unit")[1]
local px, py, pr = EntityGetTransform(player)

EntitySetTransform( player, x, y )