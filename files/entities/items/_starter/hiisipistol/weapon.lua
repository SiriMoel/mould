dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

init(weapon)
hgun( weapon, 5, 1, 1, false )
AddGunAction( weapon, "MOULD_HIISIPISTOL" )