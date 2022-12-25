dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

winit(weapon)
hgun( weapon, 5, 1, 1, false )
AddGunAction( weapon, "MOULD_HERMITPISTOL" )