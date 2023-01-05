dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local proj = GetUpdatedEntityID()

local z, i, c, v, b, n = GameGetDateAndTimeLocal()
local x, y = EntityGetTransform(proj)
math.randomseed(z+i+c+v+b+n+x+y)

local comp_proj = EntityGetFirstComponentIncludingDisabled(proj, "ProjectileComponent") or 0
local damage_melee = ComponentObjectGetValue2(comp_proj, "damage_by_type", "melee") or 0
local crit_chance = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(proj, "VariableStorageComponent", "crit_chance") or 0, "value_int") or 0
local crit_mult = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(proj, "VariableStorageComponent", "crit_mult") or 0, "value_int") or 0

if math.random(1, 100) <= crit_chance then
    damage_melee = damage_melee * crit_mult
    GamePrint("Crit!")
end

ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", damage_melee)