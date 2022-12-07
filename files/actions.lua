local to_insert = {
    {
		id = "HIISISHOTGUN",
		--name = "Hiisi Shotgun",
		name = "",
		description = "Fires 3 projectiles.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hiisishotgun/projectile.xml",3},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
        --custom_xml_file = "mods/mould/files/entities/items/hiisishotgun/card.xml",
		action = function()
			add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
            add_projectile("mods/mould/files/entities/items/hiisishotgun/projectile.xml")
			c.spread_degrees = c.spread_degrees + 13.0
		end,
	},
	{
		id = "HIISISNIPER",
		--name = "Hiisi Sniper",
		name = "",
		description = "Fires a powerful projectile.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hiisisniper/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hiisisniper/projectile.xml")
		end,
	},
	{
		id = "HIISIPISTOL",
		--name = "Hiisi Pistol",
		name = "",
		description = "Fires a projectile.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hiisipistol/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hiisipistol/projectile.xml")
		end,
	},
}

for k, v in ipairs(to_insert) do
	v.id = "MOULD_" .. v.id
    table.insert(actions, v)
end