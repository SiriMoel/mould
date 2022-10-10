dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

hgun( weapon, 6, 1, 1, false )

AddGunAction( weapon, "MOULD_HIISISNIPER" )