dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

init(weapon)
hgun( weapon, 4, 1, 2, true )
AddGunAction( weapon, "MOULD_HIISISHOTGUN" )