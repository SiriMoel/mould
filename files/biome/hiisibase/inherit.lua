dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xff80ff5a, "spawn_vines" )
RegisterSpawnFunction( 0xffff7b86, "intronpc" )
RegisterSpawnFunction( 0xffff7bb6, "armourynpc" )
RegisterSpawnFunction( 0xffff9fce, "mapnpc" )
RegisterSpawnFunction( 0xffd823bb, "map" )

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

function spawn_vines(x, y)
	spawn(g_vines,x+5,y+5)
end

function intronpc(x, y)
    EntityLoad("mods/mould/files/entities/npcs/intronpc/intronpc.xml", x, y)
end

function armourynpc(x, y)
	EntityLoad("mods/mould/files/entities/npcs/armourynpc/armourynpc.xml", x, y)
end

function mapnpc(x, y)
	EntityLoad("mods/mould/files/entities/npcs/mapnpc/mapnpc.xml", x, y)
end

function map(x, y)
	EntityLoad("mods/mould/files/entities/misc/hiisimap/map.xml", x, y)
end