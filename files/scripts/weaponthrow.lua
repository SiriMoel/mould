dofile_once("mods/mould/files/scripts/weapon.lua")

local weapon = GetUpdatedEntityID()
local player = EntityGetWithTag("player_unit")[1]
local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
local comp_ability = EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent")

if ComponentGetValue2(comp_controls, "mButtonDownThrow") == false then
    ComponentSetValue2(comp_ability, "throw_as_item", true)
else
    ComponentSetValue2(comp_ability, "throw_as_item", false)
end