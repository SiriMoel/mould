dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

function shot( projectile_entity_id )
    local weapon = GetUpdatedEntityID()
    local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
    local comp_ammouse = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_use")
    local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
    local ammouse = ComponentGetValue2(comp_ammouse, "value_int")

    local player = get_players()[1]
    local comp_inv2 = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
    local helditem = ComponentGetValue2( comp_inv2, "mActiveItem" )

    if helditem ~= weapon then return end

    ammocount = ammocount - 1

    ComponentSetValue2( comp_ammocount, "value_int", ammocount )
end