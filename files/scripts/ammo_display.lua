dofile("mods/mould/files/scripts/utils.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local comp_ammomax = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_max")
local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
local comp_ammotype = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_type")

local ammomax = ComponentGetValue2(comp_ammomax, "value_int")
local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
local ammotype = ComponentGetValue2(comp_ammotype, "value_string")