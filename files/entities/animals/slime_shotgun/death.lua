dofile_once("mods/mould/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity )
    local z, m, c, v, b, n = GameGetDateAndTimeLocal()
    math.randomseed(z+m+c+v+b+n+x+y)

    local a = math.random(1, 3)
    if a == 2 then
        EntityLoad("mods/mould/files/entities/items/hermitshotgun/weapon.xml", x, y)
    end
end