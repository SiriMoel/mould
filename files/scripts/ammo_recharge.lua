dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local comp_ammomax = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_max")
local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
local comp_ammorechargecount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_recharge_count")
if not comp_ammocount or not comp_ammomax or not comp_ammorechargecount then return end
local ammomax = ComponentGetValue2(comp_ammomax, "value_int")
local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
local ammorechargecount = ComponentGetValue2(comp_ammorechargecount, "value_int")

ammocount = ammocount + ammorechargecount

if ammocount > ammomax then
    ammocount = ammomax
end

ComponentSetValue2( comp_ammocount, "value_int", ammocount )