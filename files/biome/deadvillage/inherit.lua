CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff30ffff, "plant" )
RegisterSpawnFunction( 0xffffc94f, "lamp" )
RegisterSpawnFunction( 0xffffa776, "biglamp" )
RegisterSpawnFunction( 0xff7fb5ff, "alcoholbarrel" )
RegisterSpawnFunction( 0xffe0af9f , "rat" )
RegisterSpawnFunction( 0xffb6ac00, "mappart" )
RegisterSpawnFunction( 0xff80ff5a, "spawn_vines" ) 
RegisterSpawnFunction( 0xffcb8cff, "wanderer" )

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

g_lamp = {   
	total_prob = 0,
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_lantern.xml"
	},
}

g_rat = {
    total_prob = 0,
    {
		prob   		= 1,
		min_count	= 7,
		max_count	= 10,    
		entity 	= "data/entities/animals/rat.xml"
	},
}

g_vines =
{
	total_prob = 0,
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_long.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_short.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_shorter.xml"
	},
}


function plant(x, y)
    local plant = plants[math.random(1,#plants)]
    EntityLoad(plant, x, y)
end

function lamp(x, y)
    EntityLoad("data/entities/props/physics/lantern_small.xml", x, y)
end

function biglamp(x, y)
    spawn(g_lamp, x, y, 0, 0)
end

function alcoholbarrel(x, y)
    EntityLoad("data/entities/props/physics_brewing_stand.xml", x, y-8)
end

function rat(x, y)
    spawn(g_rat, x, y-5)
end

function mappart(x, y)
    EntityLoad("mods/mould/files/entities/items/mappiece/piece.xml", x, y-5)
end

function spawn_vines(x, y)
	spawn(g_vines,x+5,y+5)
end

function wanderer(x, y)
	EntityLoad("mods/mould/files/entities/npcs/wanderer/wanderer.xml", x, y)
end