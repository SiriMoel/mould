dofile_once("mods/mould/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
    local z, x, c, v, b, n = GameGetDateAndTimeLocal()
    math.randomseed(z+x+c+v+b+n+x+y)

    local a = math.random(1, 4)
    if a == 1 then
        EntityLoad("mods/mould/entities/items/hiisishotgun/weapon.xml")
    end
end