CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff30ffff, "plant" )
RegisterSpawnFunction( 0xffffc94f, "lamp" )
RegisterSpawnFunction( 0xffffa776, "biglamp" )

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

function plant(x, y)
    local plant = plants[math.random(1,#plants)]
    EntityLoad(plant, x, y)
end

function lamp(x, y)
    EntityLoad("data/entities/props/physics/lantern_small.xml", x, y)
end

function biglamp(x, y)
    EntityLoad("data/entities/props/physics_lantern.xml", x, y)
end