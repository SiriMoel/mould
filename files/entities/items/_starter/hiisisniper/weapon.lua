dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

init(weapon)
hgun( weapon, 6, 1, 1, false )
AddGunAction( weapon, "MOULD_HIISISNIPER" )