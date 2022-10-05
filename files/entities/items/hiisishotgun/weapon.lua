dofile("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()

hgun( weapon, 4, 1, 1, 2 )

AddGunAction( weapon, "MOULD_HIISISHOTGUN" )