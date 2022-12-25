dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

winit(weapon)
hgun( weapon, 4, 1, 1, false )
AddGunAction( weapon, "MOULD_HERMITSHOTGUN" )