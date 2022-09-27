dofile("mods/mould/files/entities/items/weapon.lua")

local weapon = GetUpdatedEntityID()

hgun( weapon, 4, 1, 1, 2 )

AddGunAction( weapon, "BUCKSHOT" )