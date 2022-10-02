CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff30ffff, "plant" )

local plants = {
    "data/entities/vegetation/tree_spruce_1.xml",
    "data/entities/vegetation/tree_spruce_2.xml",
    --"data/entities/vegetation/tree_spruce_3.xml",
    "data/entities/vegetation/tree_spruce_4.xml",
    "data/entities/vegetation/tree_spruce_5.xml",
    --"data/entities/vegetation/tree_leaf.xml",
    "data/entities/vegetation/plant_bush_1.xml",
    "data/entities/vegetation/plant_bush_2.xml",
}

local animals = {
    total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/deer.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/duck.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/elk.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 2,
		max_count	= 5,    
		entity 	= "data/entities/animals/sheep.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/wolf.xml"
	},
	{
		prob   		= 1,
		min_count	= 2,
		max_count	= 3,    
		entity 	= "data/entities/animals/rat.xml"
	},
}

function init( x, y, w, h )
    local whichscene = math.random(1,3)
    LoadPixelScene( "mods/mould/files/biome/surface/grassy_" .. whichscene .. ".png", "", x, y, "mods/mould/files/biome/hiisibase/exit_background.png", true )
end

function plant(x, y)
    local plant = plants[math.random(1,#plants)]
    EntityLoad(plant, x, y)
    spawn(animals, x, y-10)
end