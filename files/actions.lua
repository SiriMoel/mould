local a = {
    {
		id = "HERMITSTHOTGUN",
		name = "",
		description = "Fires 3 projectiles.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hermitshotgun/projectile.xml",3},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hermitshotgun/projectile.xml")
			add_projectile("mods/mould/files/entities/items/hermitshotgun/projectile.xml")
            add_projectile("mods/mould/files/entities/items/hermitshotgun/projectile.xml")
			c.spread_degrees = c.spread_degrees + 13.0
		end,
	},
	{
		id = "HERMITSNIPER",
		name = "",
		description = "Fires a fast and deadly projectile.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hermitsniper/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hermitsniper/projectile.xml")
		end,
	},
	{
		id = "HERMITPISTOL",
		name = "",
		description = "Fires a projectile.",
        sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hermitpistol/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hermitpistol/projectile.xml")
		end,
	},
	{
		id = "HERMITROCKETLAUNCHER",
		name = "",
		description = "Fires a powerful missile.",
		sprite = "mods/mould/files/misc/icon_proj.png",
		related_projectiles	= {"mods/mould/files/entities/items/hermitrocketlauncher/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hermitrocketlauncher/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
			shot_effects.recoil_knockback = 120.0
		end,
	},
	{
		id = "HERMITKNIFE",
		name = "",	
		description = "A swift stab.",
		sprite = "mods/mould/files/misc/icon_stab.png",
		related_projectiles	= {"mods/mould/files/entities/items/hermitknife/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 0,
		action = function()
			add_projectile("mods/mould/files/entities/items/hermitknife/projectile.xml")
		end,
	},
}

for i,v in ipairs(a) do
	v.id = "MOULD_" .. v.id
	v.name = ""
    table.insert(actions, v)
end