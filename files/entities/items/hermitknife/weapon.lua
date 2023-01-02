dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

winit(weapon)
hmelee( weapon, 4, 1, 2, true )
AddGunAction( weapon, "MOULD_HERMITKNIFE" )