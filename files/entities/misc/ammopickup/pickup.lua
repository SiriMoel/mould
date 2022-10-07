dofile_once("mods/mould/files/scripts/utils.lua")

function item_pickup( entity_item, entity_pickupper, item_name )
    local x, y = EntityGetTransform( entity_item )
    GamePrint("Ammo picked up!")
    local player = entity_pickupper
    local targets = EntityGetInRadiusWithTag( x, y, 24, "mould_uses_ammo" )
    for i,weapon in ipairs(targets) do
        local comp_ammomax = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_max")
        local comp_ammocount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_count")
        local comp_ammorechargecount = EntityGetFirstComponentIncludingDisabled(weapon, "VariableStorageComponent", "ammo_recharge_count")

        local ammomax = ComponentGetValue2(comp_ammomax, "value_int")
        local ammocount = ComponentGetValue2(comp_ammocount, "value_int")
        local ammorechargecount = ComponentGetValue2(comp_ammorechargecount, "value_int")

        ammocount = ammocount + ammorechargecount

        if ammocount > ammomax then
            ammocount = ammomax
        end
        
        ComponentSetValue2( comp_ammocount, "value_int", ammocount )
    end
end