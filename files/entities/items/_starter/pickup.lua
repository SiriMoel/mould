dofile_once("mods/mould/files/scripts/utils.lua")

function item_pickup( entity_item, entity_pickupper, item_name )
    local x, y = EntityGetTransform( entity_item )
    EntityRemoveTag( entity_item, "mould_starter" )
    local targets = EntityGetInRadiusWithTag( x, y, 90, "mould_starter" )
    for i,v in ipairs(targets) do
        EntityKill(v)
    end
end