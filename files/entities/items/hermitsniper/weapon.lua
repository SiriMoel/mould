dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

winit(weapon)
hgun( weapon, 6, 1, 2, true )
AddGunAction( weapon, "MOULD_HERMITSNIPER" )