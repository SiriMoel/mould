dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
local comp_ammouse = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_use")
local comp_ability = EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent")
if not comp_ammocount or not comp_ammouse or not comp_ability then return end
local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
local ammouse = ComponentGetValue2(comp_ammouse, "value_int")

if ammocount <= 0 or ammocount <= ammouse + 1 then
    ComponentSetValue2( comp_ability, "mNextFrameUsable", GameGetFrameNum() + 2)
end

--GamePrint("Ammo is " .. ammocount) -- for testing