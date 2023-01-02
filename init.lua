dofile_once( "data/scripts/lib/utilities.lua" )
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/mould/files/actions.lua" )
ModMagicNumbersFileAdd( "mods/mould/files/magic_numbers.xml" ) 
ModMaterialsFileAdd("mods/mould/files/materials.xml")
dofile_once("mods/mould/lib/DialogSystem/init.lua")("mods/mould/lib/DialogSystem")
dofile_once("mods/mould/lib/gusgui/gusgui.lua").init("mods/mould/lib/gusgui")

dofile_once("mods/mould/files/gui.lua")

local init_biome_modifiers = dofile_once( "data/scripts/biome_modifiers.lua")

function weather_init( year, month, day, hour, minute ) end

function weather_check_duration() end

--function weather_update() end

function OnBiomeConfigLoaded()
	init_biome_modifiers()
end

--[[function OnWorldPreUpdate()
	weather_update()
end]]--

function OnPlayerDied( player_entity )
	GameDestroyInventoryItems( player_entity )
	GameTriggerGameOver()
end

function OnCountSecrets()
	local secret_flags = {
		"progress_ending0",
		"progress_ending1",
		"progress_ending2",
		"progress_ngplus",
		"progress_orb_evil",
	}

	local total = GameGetOrbCountTotal() + #secret_flags
	local found = 0
	found = found + GameGetOrbCountAllTime()
	for i,it in ipairs(secret_flags) do
		if ( HasFlagPersistent(it) ) then
			found = found + 1
		end
	end

	return total,found
end

local nxml = dofile_once("mods/mould/lib/nxml.lua")

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
	while translations:find("\r\n\r\n") do
		translations = translations:gsub("\r\n\r\n","\r\n")
	end
	local new_translations = ModTextFileGetContent("mods/mould/files/misc/t.csv")
	translations = translations .. new_translations
	ModTextFileSetContent("data/translations/common.csv", translations)
end

-- biomes
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
	<Biome height_index="0" color="ffbf00a5" biome_filename="mods/mould/files/biome/solid/placeholder.xml" />
	<Biome height_index="0" color="ff890077" biome_filename="mods/mould/files/biome/solid/placeholder2.xml" />
	<Biome height_index="0" color="ff4c0043" biome_filename="mods/mould/files/biome/solid/placeholder3.xml" />

    <Biome height_index="0" color="ff6649d8" biome_filename="mods/mould/files/biome/hermitbase/main.xml" />
    <Biome height_index="0" color="ff4e46ff" biome_filename="mods/mould/files/biome/hermitbase/other.xml" /> 
    <Biome height_index="0" color="ff4e67d5" biome_filename="mods/mould/files/biome/hermitbase/exit.xml" />

    <Biome height_index="0" color="ff3d4229" biome_filename="mods/mould/files/biome/solid/cave.xml" />
    <Biome height_index="0" color="ff020202" biome_filename="mods/mould/files/biome/solid/empty.xml" />
    <Biome height_index="0" color="ff003f31" biome_filename="mods/mould/files/biome/solid/swamp.xml" />
	<Biome height_index="0" color="ff31332b" biome_filename="mods/mould/files/biome/solid/underground.xml" />
	<Biome height_index="0" color="ff1c1717" biome_filename="mods/mould/files/biome/solid/charcoal.xml" />
    
    <Biome height_index="0" color="ff5d9135" biome_filename="mods/mould/files/biome/surface/grassy.xml" />

    <Biome height_index="0" color="ffffb075" biome_filename="mods/mould/files/biome/deadvillage/1.xml" />
    <Biome height_index="0" color="ffffbd8e" biome_filename="mods/mould/files/biome/deadvillage/2.xml" />
    <Biome height_index="0" color="ffffa35b" biome_filename="mods/mould/files/biome/deadvillage/well.xml" />
    <Biome height_index="0" color="ffff9442" biome_filename="mods/mould/files/biome/deadvillage/3.xml" />
    <Biome height_index="0" color="ffff885b" biome_filename="mods/mould/files/biome/deadvillage/well_down.xml" />

    <Biome height_index="0" color="ff002f25" biome_filename="mods/mould/files/biome/caverns/solidborder_1.xml" />
    <Biome height_index="0" color="ff9fff18" biome_filename="mods/mould/files/biome/caverns/enter.xml" />
    <Biome height_index="0" color="ff76ce12" biome_filename="mods/mould/files/biome/caverns/swamp/swamp.xml" />
	<Biome height_index="0" color="ff514343" biome_filename="mods/mould/files/biome/caverns/charcoal/charcoal.xml" />
	<Biome height_index="0" color="ff82c151" biome_filename="mods/mould/files/biome/caverns/moss/moss.xml" />
	<Biome height_index="0" color="ff86d9ff" biome_filename="mods/mould/files/biome/caverns/heartlair/heartlair.xml" />
	<Biome height_index="0" color="ff4c4f43" biome_filename="mods/mould/files/biome/caverns/solidborder_underground.xml" />
	<Biome height_index="0" color="ff60a80f" biome_filename="mods/mould/files/biome/caverns/swamp_boss/enter.xml" />
	<Biome height_index="0" color="ff7e3126" biome_filename="mods/mould/files/biome/caverns/solidborder_2.xml" />

	<Biome height_index="0" color="ff9f3126" biome_filename="mods/mould/files/biome/caverns/opening_down_l.xml" />
	<Biome height_index="0" color="ffb5362b" biome_filename="mods/mould/files/biome/caverns/opening_down_m.xml" />
	<Biome height_index="0" color="ffce3e31" biome_filename="mods/mould/files/biome/caverns/opening_down_r.xml" />

	<Biome height_index="0" color="ff0075b6" biome_filename="mods/mould/files/biome/ocean/surface/surface.xml" />
	<Biome height_index="0" color="ff005c8e" biome_filename="mods/mould/files/biome/ocean/water/water.xml" />
	<Biome height_index="0" color="ff931d4c" biome_filename="mods/mould/files/biome/ocean/death/surface.xml" />
	<Biome height_index="0" color="ff7c1840" biome_filename="mods/mould/files/biome/ocean/death/water.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- set
ModTextFileSetContent( "data/biome/_pixel_scenes.xml", ModTextFileGetContent("mods/mould/files/set/_pixel_scenes.xml") )
ModTextFileSetContent( "data/scripts/items/drop_money.lua", ModTextFileGetContent("mods/mould/files/set/drop_money.lua") )
--ModTextFileSetContent( "data/entities/player_base.xml", ModTextFileGetContent("mods/mould/files/set/player_base.xml") )

-- player
local dx = 1732
local dy = 1764
--SetPlayerSpawnLocation( dx, dy )

function OnPlayerSpawned( player ) 
    
    if GameHasFlagRun("mouldplayer") then return end

    EntityLoad("mods/mould/files/entities/items/hermitshotgun/weapon.xml", dx, dy-10)
    EntityLoad("mods/mould/files/entities/items/hermitsniper/weapon.xml", dx, dy-12)
    EntityLoad("mods/mould/files/entities/items/hermitpistol/weapon.xml", dx, dy-14)

    --print(BiomeMapGetName(dx, dy))

    EntitySetTransform(player, dx, dy)
    
    GameAddFlagRun("mouldplayer") 

	EntityAddComponent( player, "LuaComponent", {
		script_source_file="mods/mould/files/scripts/movement.lua",
		execute_every_n_frame="1",
	} )
	EntityAddComponent( player, "VariableStorageComponent", {
		_tags="movetimer",
		name="movetimer",
		value_int="0",
	} )
	EntityAddComponent( player, "VariableStorageComponent", {
		_tags="kickcd",
		name="kickcd",
		value_int="0",
	} )

	local comp_kick = EntityGetFirstComponentIncludingDisabled( player, "KickComponent" )
	if comp_kick ~= nil then
		--ComponentSetValue2( comp_kick, "kick_entities", "mods/mould/files/entities/misc/playerkick/kick.xml" )
		ComponentSetValue2( comp_kick, "kick_radius", 3.5 )
	end


	local comp_cp = EntityGetFirstComponentIncludingDisabled( player, "CharacterPlatformingComponent" ) or 0
	local comp_cd = EntityGetFirstComponentIncludingDisabled( player, "CharacterDataComponent" ) or 0

	local velocity_min_x = ComponentGetValue2( comp_cp, "velocity_min_x" )
    local velocity_max_x = ComponentGetValue2( comp_cp, "velocity_max_x" )
    local velocity_min_y = ComponentGetValue2( comp_cp, "velocity_min_y" )
    local velocity_max_y = ComponentGetValue2( comp_cp, "velocity_max_y" )
	local jumpvelox = ComponentGetValue2( comp_cp, "jump_velocity_x" ) 
    local jumpveloy = ComponentGetValue2( comp_cp, "jump_velocity_y" )
	local fly_speed_max_down = ComponentGetValue2( comp_cp, "fly_speed_max_down" )
	velocity_min_x = velocity_min_x * 1.2
	velocity_max_x = velocity_max_x * 1.2
	velocity_min_y = velocity_min_y * 1.2
	velocity_max_y = velocity_max_y * 1.2
	jumpvelox = jumpvelox * 1.5
	jumpveloy = jumpveloy * 1.5
	fly_speed_max_down = fly_speed_max_down * 3
	ComponentSetValue2( comp_cp, "velocity_min_x", velocity_min_x )
    ComponentSetValue2( comp_cp, "velocity_max_x", velocity_max_x )
    ComponentSetValue2( comp_cp, "velocity_min_y", velocity_min_y )
    ComponentSetValue2( comp_cp, "velocity_max_y", velocity_max_y )
	ComponentSetValue2( comp_cp, "jump_velocity_x", jumpvelox )
    ComponentSetValue2( comp_cp, "jump_velocity_y", jumpveloy )
	ComponentSetValue2( comp_cp, "fly_speed_max_down", fly_speed_max_down )
	ComponentSetValue2( comp_cd, "fly_time_max", 0 )
	
    local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
        local xx = 0.9

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