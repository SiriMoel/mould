local to_insert = {
    {
		id          = "MOULD_HIISISHOTGUN",
		name 		= "Hiisi Shotgun",
		description = "Fires 3 projectiles.",
		--sprite 		= "data/ui_gfx/inventory/icon_info.png",
        sprite 		= "mods/mould/files/misc/info_icon.png",
		related_projectiles	= {"mods/mould/files/entities/items/hiisishotgun/projectile.xml",3},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 0,
        --custom_xml_file = "mods/mould/files/entities/items/hiisishotgun/card.xml",
		action = function()
			add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
            add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.spread_degrees = c.spread_degrees + 14.0
		end,
	},
}

for k, v in ipairs(to_insert) do
    table.insert(actions, v)
end