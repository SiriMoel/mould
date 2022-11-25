dofile_once("mods/mould/files/scripts/status_utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
    ApplyStatus("toxic_slimed")
end