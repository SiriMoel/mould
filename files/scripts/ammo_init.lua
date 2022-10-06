dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local comp_ammomax = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_max")
local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
local comp_ammorecharge = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_recharge")
local comp_ammorechargecount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_recharge_count")
local comp_ammouse = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_use")
local comp_ammotype = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_type")

local ammomax = ComponentGetValue2(comp_ammomax, "value_int")
local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
local ammorecharge = ComponentGetValue2(comp_ammorecharge, "value_int")
local ammorechargecount = ComponentGetValue2(comp_ammorechargecount, "value_int")
local ammouse = ComponentGetValue2(comp_ammouse, "value_int")
local ammotype = ComponentGetValue2(comp_ammotype, "value_string")

-- recharge
EntityAddComponent( weapon, "LuaComponent", {
    _tags="enabled_in_hand,enabled_in_inventory",
    execute_every_n_frame=ammorecharge,
    script_source_file="mods/mould/files/scripts/ammo_recharge.lua",
} )

-- gui
EntityAddComponent( weapon, "LuaComponent", {
    _tags="enabled_in_world",
    execute_every_n_frame="1",
    script_source_file="mods/mould/files/scripts/ammo_display.lua",
} )

-- check
EntityAddComponent( weapon, "LuaComponent", {
    _tags="enabled_in_hand,enabled_in_inventory,enabled_in_world",
    execute_every_n_frame="1",
    script_source_file="mods/mould/files/scripts/ammo_check.lua",
} )

-- fire
EntityAddComponent( weapon, "LuaComponent", {
    _tags="enabled_in_hand",
    script_shot="mods/mould/files/scripts/ammo_fire.lua",
} )