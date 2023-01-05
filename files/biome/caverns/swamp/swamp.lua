CHEST_LEVEL = 3
dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffb4a700, "bogstructure" )
RegisterSpawnFunction( 0xffc7a1dc, "enemy_ground") --[[
    slime-possessed shotgunner (shotgunner with special slime attack)
    slimey mass (zombie-like thing that lunges at player)
    slightly ominous cube
    group of small creatures that dont move much but jump at the player, turning nearby oil into toxic slime
]]--
RegisterSpawnFunction( 0xffe80000, "enemy_flying" ) --[[
    slightly ominous cube (gelatinous cube (dnd) but cooler, fast but clunky movement, drops kinda random loot)
    slime-possessed guns (shotgun, pistol, sniper)
    slime bat thing that latches onto the player for a period of time draining health
    ochre jelly like creature (but green) that spews toxic gas and moves very slowly
]]--
RegisterSpawnFunction( 0xff1635ff, "enemy_miniboss" ) --[[
    very ominous cube (gelatinous cube (dnd) but coolerer, fast but clunky movement, drops very random loot)
]]--

local structures = { -- these are placeholders
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree1.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree2.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree3.xml",
}

g_enemy_ground = {
    total_prob = 0,
    {
        prob = 1,
        min_count = 0,
        max_count = 0,
        entity = "",
    },
    {
        prob = 0.3,
        min_count = 1,
        max_count = 1,
        entity = "mods/mould/files/entities/animals/ominous_cube_weak/entity.xml",
    },
    {
        prob = 0.6,
        min_count = 1,
        max_count = 1,
        entity = "mods/mould/files/entities/animals/slime_shotgunner/entity.xml",
    },
}

g_enemy_flying = {
    total_prob = 0,
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "",
    },
    {
        prob = 1,
        min_count = 1,
        max_count = 2,
        entity = "mods/mould/files/entities/animals/slime_shotgun/entity.xml",
    },
    --[[{
        prob = 0.2,
        min_count = 1,
        max_count = 1,
        entity = "mods/mould/files/entities/animals/ominous_cube_weak/entity.xml",
    },]]--
}

g_enemy_miniboss = {
    total_prob = 0,
}

function init( x, y, w, h ) end

function bogstructure( x, y )
    local structure = structures[math.random(1,#structures)]
    EntityLoad(structure, x, y)
end

function enemy_ground( x, y ) 
    spawn(g_enemy_ground, x, y)
end

function enemy_flying( x, y )
    spawn(g_enemy_flying, x, y)
end

function enemy_miniboss( x, y ) 
    spawn(g_enemy_miniboss, x, y)
end