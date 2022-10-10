ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/mould/files/actions.lua" )
ModMagicNumbersFileAdd( "mods/mould/files/magic_numbers.xml" ) 
dofile_once("mods/mould/lib/DialogSystem/init.lua")("mods/mould/lib/DialogSystem")
dofile_once("mods/mould/lib/gusgui/gusgui.lua").init("mods/mould/lib/gusgui")


local nxml = dofile_once("mods/mould/lib/nxml.lua")

-- translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
	while translations:find("\r\n\r\n") do
		translations = translations:gsub("\r\n\r\n","\r\n");
	end
	local new_translations = ModTextFileGetContent( "mods/mould/files/misc/t.csv" );
	translations = translations .. new_translations;
	ModTextFileSetContent( "data/translations/common.csv", translations );
end

-- biomes
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff6649d8" biome_filename="mods/mould/files/biome/hiisibase/main.xml" />
    <Biome height_index="0" color="ff4e46ff" biome_filename="mods/mould/files/biome/hiisibase/other.xml" /> 
    <Biome height_index="0" color="ff4e67d5" biome_filename="mods/mould/files/biome/hiisibase/exit.xml" />

    <Biome height_index="0" color="ff3d4229" biome_filename="mods/mould/files/biome/solid/cave.xml" />
    <Biome height_index="0" color="ff020202" biome_filename="mods/mould/files/biome/solid/empty.xml" />
    <Biome height_index="0" color="ff003f31" biome_filename="mods/mould/files/biome/solid/swamp.xml" />
    
    <Biome height_index="0" color="ff5d9135" biome_filename="mods/mould/files/biome/surface/grassy.xml" />

    <Biome height_index="0" color="ffffb075" biome_filename="mods/mould/files/biome/deadvillage/1.xml" />
    <Biome height_index="0" color="ffffbd8e" biome_filename="mods/mould/files/biome/deadvillage/2.xml" />
    <Biome height_index="0" color="ffffa35b" biome_filename="mods/mould/files/biome/deadvillage/well.xml" />
    <Biome height_index="0" color="ffff9442" biome_filename="mods/mould/files/biome/deadvillage/3.xml" />
    <Biome height_index="0" color="ffff885b" biome_filename="mods/mould/files/biome/deadvillage/well_down.xml" />

    <Biome height_index="0" color="ff002f25" biome_filename="mods/mould/files/biome/caverns/solidborder_1.xml" />
    <Biome height_index="0" color="ff9fff18" biome_filename="mods/mould/files/biome/caverns/enter.xml" />
    <Biome height_index="0" color="ff76ce12" biome_filename="mods/mould/files/biome/caverns/swamp/swamp.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- set
ModTextFileSetContent( "data/biome/_pixel_scenes.xml", ModTextFileGetContent("mods/mould/files/set/_pixel_scenes.xml") )
ModTextFileSetContent( "data/scripts/items/drop_money.lua", ModTextFileGetContent("mods/mould/files/set/drop_money.lua") )

-- player
local dx = 1732
local dy = 1764
--SetPlayerSpawnLocation( dx, dy )

function OnPlayerSpawned( player ) 
    
    if GameHasFlagRun("mouldplayer") then return end

    EntityLoad("mods/mould/files/entities/items/hiisishotgun/weapon.xml", dx, dy-10)
    EntityLoad("mods/mould/files/entities/items/hiisisniper/weapon.xml", dx, dy-12)
    --EntityLoad("mods/mould/files/entities/items/hiisishotgun/weapon.xml", dx, dy-14)

    --print(BiomeMapGetName(dx, dy))

    EntitySetTransform(player, dx, dy)
    
    GameAddFlagRun("mouldplayer")

    local damagemodels = EntityGetComponent( player_entity, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
        local xx = 0
        if ModSettingGet("mould.difficulty") == "easy" then
            xx = 0.6
        end
        if ModSettingGet("mould.difficulty") == "normal" then
            xx = 1
        end
        if ModSettingGet("mould.difficulty") == "hard" then
            xx = 1.2
        end
        if ModSettingGet("mould.difficulty") == "expert" then
            xx = 1.5
        end

		for i,damagemodel in ipairs(damagemodels) do
			local melee = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "melee" ) )
			local projectile = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "projectile" ) )
			local explosion = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "explosion" ) )
			local electricity = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "electricity" ) )
			local fire = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "fire" ) )
			local drill = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "drill" ) )
			local slice = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "slice" ) )
			local ice = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "ice" ) )
			local healing = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "healing" ) )
			local physics_hit = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "physics_hit" ) )
			local radioactive = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "radioactive" ) )
			local poison = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "poison" ) )

			melee = melee * xx
			projectile = projectile * xx
			explosion = explosion * xx
			electricity = electricity * xx
			fire = fire * xx
			drill = drill * xx
			slice = slice * xx
			ice = ice * xx
            healing = healing * xx
            physics_hit = physics_hit * xx
			radioactive = radioactive * xx
			poison = poison * xx

			ComponentObjectSetValue( damagemodel, "damage_multipliers", "melee", tostring(melee) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", tostring(projectile) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "explosion", tostring(explosion) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "electricity", tostring(electricity) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "fire", tostring(fire) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "drill", tostring(drill) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "slice", tostring(slice) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "ice", tostring(ice) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "healing", tostring(healing) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "physics_hit", tostring(physics_hit) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "radioactive", tostring(radioactive) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "poison", tostring(poison) )
		end
    end
end